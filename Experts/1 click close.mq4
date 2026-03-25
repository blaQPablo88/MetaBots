//+------------------------------------------------------------------+
//|                  Momentum Multi-Pair + 1-Click Close             |
//|                  Kagiso / Ruggggalllll Bernstttteiiin            |
//|                  Version 1.05                                    |
//+------------------------------------------------------------------+
#property copyright "Ruggggalllll Bernstttteiiin"
#property link      "https://github.com/blaQPablo88/MetaBots"
#property version   "1.05"
#property strict

//--- Input parameters
extern int    MagicNumber      = 123456;     // 0 = close ALL orders (emergency mode)
extern double MaxOrders        = 50;         // Global order limit
extern bool   TradeOnNewBar    = true;

// Symbol groups
string WeakUSD_Symbols[]   = {"EURUSDm","GBPUSDm","NZDUSDm","AUDUSDm"};
string StrongUSD_Symbols[] = {"USDCADm","USDCHFm","USDJPYm","USDSEKm"};

double WeakLots   = 0.06;
double StrongLots = 0.04;

// SL/TP in points
int WeakBuy_SL_Points   = 300;
int WeakBuy_TP_Points   = 70;
int StrongSell_SL_Points = 250;
int StrongSell_TP_Points = 85;

//--- Button settings
string ButtonName = "EmergencyCloseButton";

//+------------------------------------------------------------------+
//| Safe OrderSend helper                                            |
//+------------------------------------------------------------------+
int SafeOrderSend(string symbol, int cmd, double volume, double price,
                  int slippage, double sl, double tp, string comment="")
{
   if(volume <= 0) return -1;

   if(!SymbolSelect(symbol, true))
   {
      Print("Failed to select symbol: ", symbol);
      return -1;
   }

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
   {
      int err = GetLastError();
      Print("OrderSend failed | Symbol=", symbol, " Cmd=", cmd, " Error=", err);
   }
   else
      Print("Order opened | Ticket=", ticket, " Symbol=", symbol, " Comment=", comment);

   return ticket;
}

//+------------------------------------------------------------------+
//| Safe Close All Orders (improved & cleaned)                       |
//+------------------------------------------------------------------+
int CloseAllOrders(int magic, int slippage = 10)
{
   int closed = 0;
   bool retry = true;

   while(retry)
   {
      retry = false;
      for(int i = OrdersTotal() - 1; i >= 0; i--)   // reverse loop is safer
      {
         if(!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) continue;

         // Filter by magic (0 = close everything)
         if(magic != 0 && OrderMagicNumber() != magic) continue;

         double closePrice = 0;
         color  arrowColor = clrNONE;

         switch(OrderType())
         {
            case OP_BUY:
               closePrice = Bid;
               arrowColor = clrBlue;
               if(OrderClose(OrderTicket(), OrderLots(), closePrice, slippage, arrowColor))
               {
                  Print("Buy order closed: ", OrderTicket());
                  closed++;
               }
               else retry = true;   // will retry on next loop
               break;

            case OP_SELL:
               closePrice = Ask;
               arrowColor = clrRed;
               if(OrderClose(OrderTicket(), OrderLots(), closePrice, slippage, arrowColor))
               {
                  Print("Sell order closed: ", OrderTicket());
                  closed++;
               }
               else retry = true;
               break;

            case OP_BUYLIMIT:
            case OP_BUYSTOP:
            case OP_SELLLIMIT:
            case OP_SELLSTOP:
               if(OrderDelete(OrderTicket(), clrBlue))
               {
                  Print("Pending order deleted: ", OrderTicket());
                  closed++;
               }
               else retry = true;
               break;
         }

         // Small delay on retry to avoid server overload
         if(retry) Sleep(50);
      }
   }

   if(closed > 0)
      Print("=== Emergency Close completed. Total closed/deleted: ", closed, " ===");

   return closed;
}

//+------------------------------------------------------------------+
//| Expert initialization                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   // Create emergency button
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
   ObjectSetString(0, ButtonName, OBJPROP_TEXT, "CLOSE ALL ORDERS & PENDINGS");
   ObjectSetInteger(0, ButtonName, OBJPROP_COLOR, clrWhite);
   ObjectSetInteger(0, ButtonName, OBJPROP_BGCOLOR, clrRed);
   ObjectSetInteger(0, ButtonName, OBJPROP_BORDER_TYPE, BORDER_FLAT);
   ObjectSetInteger(0, ButtonName, OBJPROP_FONTSIZE, 11);
   ObjectSetInteger(0, ButtonName, OBJPROP_SELECTABLE, false);

   Print("Emergency Close button created successfully.");
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization                                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   ObjectsDeleteAll(0, -1, -1);   // clean up all objects
}

//+------------------------------------------------------------------+
//| Chart Event Handler (Button click)                               |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
   if(id == CHARTEVENT_OBJECT_CLICK && sparam == ButtonName)
   {
      Print("🚨 Emergency Close button clicked!");

      // Optional: Ask for confirmation (uncomment if you want)
      // if(MessageBox("Close ALL orders and pending orders?", "EMERGENCY CLOSE", MB_YESNO|MB_ICONWARNING) == IDYES)

      CloseAllOrders(MagicNumber, 10);   // Change to 0 to close everything on the account
   }
}

//+------------------------------------------------------------------+
//| Main OnTick - Trading Logic                                      |
//+------------------------------------------------------------------+
void OnTick()
{
   static datetime lastBarTime = 0;

   if(TradeOnNewBar)
   {
      if(Time[0] == lastBarTime) return;
      lastBarTime = Time[0];
   }

   if(OrdersTotal() >= MaxOrders) return;

   // --- Indicators ---
   double ma = iMA(Symbol(), 0, 15, 0, MODE_SMA, PRICE_MEDIAN, 0);

   double currentPrice = Close[0];
   double prevPrice    = Close[1];

   bool bullishSignal = (currentPrice < ma) && (currentPrice > prevPrice);
   bool bearishSignal = (currentPrice > ma) && (currentPrice < prevPrice);

   // ===================== BULLISH SIGNAL =====================
   if(bullishSignal)
   {
      // Sell strong USD pairs
      for(int i = 0; i < ArraySize(StrongUSD_Symbols); i++)
      {
         string sym   = StrongUSD_Symbols[i];
         double bid   = SymbolInfoDouble(sym, SYMBOL_BID);
         double point = SymbolInfoDouble(sym, SYMBOL_POINT);

         SafeOrderSend(sym, OP_SELL, StrongLots, bid, 3,
                       bid + StrongSell_SL_Points * point,
                       bid - StrongSell_TP_Points * point,
                       "StrongUSD_Sell");
      }

      // Buy weak USD pairs
      for(int i = 0; i < ArraySize(WeakUSD_Symbols); i++)
      {
         string sym   = WeakUSD_Symbols[i];
         double ask   = SymbolInfoDouble(sym, SYMBOL_ASK);
         double point = SymbolInfoDouble(sym, SYMBOL_POINT);

         SafeOrderSend(sym, OP_BUY, WeakLots, ask, 3,
                       ask - WeakBuy_SL_Points * point,
                       ask + WeakBuy_TP_Points * point,
                       "WeakUSD_Buy");
      }
   }

   // ===================== BEARISH SIGNAL =====================
   if(bearishSignal)
   {
      // Buy strong USD pairs
      for(int i = 0; i < ArraySize(StrongUSD_Symbols); i++)
      {
         string sym   = StrongUSD_Symbols[i];
         double ask   = SymbolInfoDouble(sym, SYMBOL_ASK);
         double point = SymbolInfoDouble(sym, SYMBOL_POINT);

         SafeOrderSend(sym, OP_BUY, StrongLots, ask, 3,
                       ask - StrongSell_SL_Points * point,
                       ask + StrongSell_TP_Points * point,
                       "StrongUSD_Buy");
      }

      // Sell weak USD pairs
      for(int i = 0; i < ArraySize(WeakUSD_Symbols); i++)
      {
         string sym   = WeakUSD_Symbols[i];
         double bid   = SymbolInfoDouble(sym, SYMBOL_BID);
         double point = SymbolInfoDouble(sym, SYMBOL_POINT);

         SafeOrderSend(sym, OP_SELL, WeakLots, bid, 3,
                       bid + WeakBuy_SL_Points * point,
                       bid - WeakBuy_TP_Points * point,
                       "WeakUSD_Sell");
      }
   }
}