//+------------------------------------------------------------------+
//|     Momentum Multi-Pair + Emergency Close + DXY Confirmation     |
//|                  Version 1.06                                    |
//+------------------------------------------------------------------+
#property copyright "Ruggggalllll Bernstttteiii"
#property link      "https://github.com/blaQPablo88/MetaBots"
#property version   "1.06"
#property strict

#include <SymbolGroups.mqh>

extern int    MagicNumber      = 123456;     // 0 = close ALL orders
extern double MaxOrders        = 50;
extern bool   TradeOnNewBar    = true;
extern bool   UseDXYFilter     = true;       // Turn DXY confirmation on/off

string ButtonName = "EmergencyCloseButton";

//+------------------------------------------------------------------+
//| Safe OrderSend                                                   |
//+------------------------------------------------------------------+
int SafeOrderSend(string symbol, int cmd, double volume, double price,
                  int slippage, double sl, double tp, string comment="")
{
   if(volume <= 0) return -1;
   if(!SymbolSelect(symbol, true)) return -1;

   double point  = SymbolInfoDouble(symbol, SYMBOL_POINT);
   int    digits = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);

   price  = NormalizeDouble(price, digits);
   sl     = (sl > 0) ? NormalizeDouble(sl, digits) : 0;
   tp     = (tp > 0) ? NormalizeDouble(tp, digits) : 0;
   volume = NormalizeDouble(volume, 2);

   color clr = (cmd == OP_BUY || cmd == OP_BUYSTOP) ? clrGreen : clrRed;

   int ticket = OrderSend(symbol, cmd, volume, price, slippage, sl, tp,
                          comment, MagicNumber, 0, clr);

   if(ticket < 0)
      Print("OrderSend failed | Symbol=", symbol, " Error=", GetLastError());
   else
      Print("Order opened | Ticket=", ticket, " | ", comment);

   return ticket;
}

//+------------------------------------------------------------------+
//| Safe Close All Orders                                            |
//+------------------------------------------------------------------+
int CloseAllOrders(int magic, int slippage = 10)
{
   int closed = 0;
   for(int i = OrdersTotal()-1; i >= 0; i--)
   {
      if(!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) continue;
      if(magic != 0 && OrderMagicNumber() != magic) continue;

      bool success = false;
      switch(OrderType())
      {
         case OP_BUY:  success = OrderClose(OrderTicket(), OrderLots(), Bid, slippage, clrBlue); break;
         case OP_SELL: success = OrderClose(OrderTicket(), OrderLots(), Ask, slippage, clrRed); break;
         default:      success = OrderDelete(OrderTicket(), clrBlue); break;
      }
      if(success) closed++;
   }
   if(closed > 0) Print("Emergency close completed: ", closed, " orders/pendings");
   return closed;
}

//+------------------------------------------------------------------+
//| OnInit - Create Button                                           |
//+------------------------------------------------------------------+
int OnInit()
{
   if(!ObjectCreate(0, ButtonName, OBJ_BUTTON, 0, 0, 0))
   {
      Print("Failed to create button. Error: ", GetLastError());
      return INIT_FAILED;
   }

   ObjectSetInteger(0, ButtonName, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
   ObjectSetInteger(0, ButtonName, OBJPROP_XDISTANCE, 20);
   ObjectSetInteger(0, ButtonName, OBJPROP_YDISTANCE, 20);
   ObjectSetInteger(0, ButtonName, OBJPROP_XSIZE, 340);
   ObjectSetInteger(0, ButtonName, OBJPROP_YSIZE, 40);
   ObjectSetString(0, ButtonName, OBJPROP_TEXT, "🚨 CLOSE ALL ORDERS & PENDINGS");
   ObjectSetInteger(0, ButtonName, OBJPROP_COLOR, clrWhite);
   ObjectSetInteger(0, ButtonName, OBJPROP_BGCOLOR, clrRed);
   ObjectSetInteger(0, ButtonName, OBJPROP_FONTSIZE, 11);
   ObjectSetInteger(0, ButtonName, OBJPROP_SELECTABLE, false);

   Print("EA initialized with Emergency Button + DXY Filter");
   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| OnDeinit                                                         |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   ObjectsDeleteAll();
}

//+------------------------------------------------------------------+
//| OnChartEvent - Button click                                      |
//+------------------------------------------------------------------+
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   if(id == CHARTEVENT_OBJECT_CLICK && sparam == ButtonName)
      CloseAllOrders(MagicNumber, 10);
}

//+------------------------------------------------------------------+
//| OnTick                                                           |
//+------------------------------------------------------------------+
void OnTick()
{
   static datetime lastBarTime = 0;
   if(TradeOnNewBar && Time[0] == lastBarTime) return;
   lastBarTime = Time[0];

   if(OrdersTotal() >= MaxOrders) return;

   double ma = iMA(Symbol(), 0, 15, 0, MODE_SMA, PRICE_MEDIAN, 0);
   double curr = Close[0];
   double prev = Close[1];

   bool bullishSignal = (curr < ma) && (curr > prev);
   bool bearishSignal = (curr > ma) && (curr < prev);

   // DXY Confirmation
   bool dxyFalling = true, dxyRising = true;
   if(UseDXYFilter)
   {
      double dxyCurr = iClose(DXY_Symbol, 0, 0);
      double dxyPrev = iClose(DXY_Symbol, 0, 1);
      dxyFalling = (dxyCurr < dxyPrev);
      dxyRising  = (dxyCurr > dxyPrev);
   }

   // Bullish Signal → Buy weak USD (if DXY falling)
   if(bullishSignal && (!UseDXYFilter || dxyFalling))
   {
      for(int i=0; i<ArraySize(WeakUSD_Symbols); i++)
      {
         string sym = WeakUSD_Symbols[i];
         double ask = SymbolInfoDouble(sym, SYMBOL_ASK);
         double pt  = SymbolInfoDouble(sym, SYMBOL_POINT);
         SafeOrderSend(sym, OP_BUY, WeakLots, ask, 3,
                       ask - WeakBuy_SL_Points*pt,
                       ask + WeakBuy_TP_Points*pt,
                       "WeakUSD_Buy_DXYconf");
      }
   }

   // Bearish Signal → Sell strong USD (if DXY rising)
   if(bearishSignal && (!UseDXYFilter || dxyRising))
   {
      for(int i=0; i<ArraySize(StrongUSD_Symbols); i++)
      {
         string sym = StrongUSD_Symbols[i];
         double bid = SymbolInfoDouble(sym, SYMBOL_BID);
         double pt  = SymbolInfoDouble(sym, SYMBOL_POINT);
         SafeOrderSend(sym, OP_SELL, StrongLots, bid, 3,
                       bid + StrongSell_SL_Points*pt,
                       bid - StrongSell_TP_Points*pt,
                       "StrongUSD_Sell_DXYconf");
      }
   }
}