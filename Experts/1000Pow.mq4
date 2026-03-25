//+------------------------------------------------------------------+
//| Expert Advisor properties                                        |
//+------------------------------------------------------------------+
#property copyright "Kagiso Mogotsi"
#property version   "1.04"
#property strict

extern int    MagicNumber      = 123456;     // Unique ID for your orders
extern double MaxOrders        = 50;         // Much safer than 170
extern bool   TradeOnNewBar    = true;       // Highly recommended

// Symbol list - easy to maintain
string BuySymbols[]  = {"EURUSDm","GBPUSDm","NZDUSDm","AUDUSDm","DXYm"};
string SellSymbols[] = {"USDCADm","USDCHFm","USDJPYm","USDSEKm"};

double BuyLots  = 0.06;
double SellLots = 0.04;

// SL/TP in points (will be converted correctly per symbol)
int BuySL_Points   = 300;
int BuyTP_Points   = 70;
int SellSL_Points  = 250;
int SellTP_Points  = 85;

//+------------------------------------------------------------------+
//| Helper: Safe OrderSend with error handling                       |
//+------------------------------------------------------------------+
int SafeOrderSend(string symbol, int cmd, double volume, double price,
                  int slippage, double sl, double tp, string comment="")
{
   if(volume <= 0) return -1;
   
   // Ensure symbol is in Market Watch
   if(SymbolInfoInteger(symbol, SYMBOL_SELECT) == false)
      if(!SymbolSelect(symbol, true))
      {
         Print("Failed to select symbol: ", symbol);
         return -1;
      }
   
   double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
   int    digits = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
   
   // Normalize everything
   price = NormalizeDouble(price, digits);
   sl    = (sl > 0)    ? NormalizeDouble(sl, digits)    : 0;
   tp    = (tp > 0)    ? NormalizeDouble(tp, digits)    : 0;
   volume = NormalizeDouble(volume, 2);   // most brokers use 2 decimals for lots
   
   int ticket = OrderSend(symbol, cmd, volume, price, slippage, sl, tp, comment, MagicNumber, 0, 
                          (cmd==OP_BUY || cmd==OP_BUYSTOP)? clrGreen : clrRed);
   
   if(ticket < 0)
   {
      int err = GetLastError();
      Print("OrderSend failed | Symbol=", symbol, " | Cmd=", cmd, " | Error=", err, " | ", ErrorDescription(err));
   }
   else
      Print("Order opened successfully | Ticket=", ticket, " | Symbol=", symbol);
   
   return ticket;
}

//+------------------------------------------------------------------+
//| OnTick                                                           |
//+------------------------------------------------------------------+
void OnTick()
{
   static datetime lastBarTime = 0;
   
   // === Trade only on new bar (prevents spam) ===
   if(TradeOnNewBar)
   {
      datetime currentBarTime = Time[0];
      if(currentBarTime == lastBarTime) return;
      lastBarTime = currentBarTime;
   }
   
   if(OrdersTotal() >= MaxOrders) return;   // Global limit
   
   // --- Indicators & Prices ---
   double ma = iMA(Symbol(), 0, 15, 0, MODE_SMA, PRICE_MEDIAN, 0);
   
   double currentPrice = Close[0];   // Better than Open[0] for current price
   double lastPrice    = Close[1];
   
   // --- BUYING CONDITION (price below MA and rising) ---
   if(currentPrice < ma && currentPrice > lastPrice)
   {
      // Sell the "strong USD" pairs
      for(int i=0; i<ArraySize(SellSymbols); i++)
      {
         string sym = SellSymbols[i];
         double bid = SymbolInfoDouble(sym, SYMBOL_BID);
         double point = SymbolInfoDouble(sym, SYMBOL_POINT);
         
         SafeOrderSend(sym, OP_SELL, SellLots, bid, 3,
                       bid + SellSL_Points * point,
                       bid - SellTP_Points * point,
                       "Sell USD");
      }
      
      // Buy the "weak USD" pairs
      for(int i=0; i<ArraySize(BuySymbols); i++)
      {
         string sym = BuySymbols[i];
         double ask = SymbolInfoDouble(sym, SYMBOL_ASK);
         double point = SymbolInfoDouble(sym, SYMBOL_POINT);
         
         SafeOrderSend(sym, OP_BUY, BuyLots, ask, 3,
                       ask - BuySL_Points * point,
                       ask + BuyTP_Points * point,
                       "Buy vs USD");
      }
   }
   
   // --- SELLING CONDITION (price above MA and falling) ---
   if(currentPrice > ma && currentPrice < lastPrice)
   {
      // Buy the "strong USD" pairs
      for(int i=0; i<ArraySize(SellSymbols); i++)
      {
         string sym = SellSymbols[i];
         double ask = SymbolInfoDouble(sym, SYMBOL_ASK);
         double point = SymbolInfoDouble(sym, SYMBOL_POINT);
         
         SafeOrderSend(sym, OP_BUY, SellLots, ask, 3,
                       ask - SellSL_Points * point,     // corrected logic
                       ask + SellTP_Points * point,
                       "Buy USD");
      }
      
      // Sell the "weak USD" pairs
      for(int i=0; i<ArraySize(BuySymbols); i++)
      {
         string sym = BuySymbols[i];
         double bid = SymbolInfoDouble(sym, SYMBOL_BID);
         double point = SymbolInfoDouble(sym, SYMBOL_POINT);
         
         SafeOrderSend(sym, OP_SELL, BuyLots, bid, 3,
                       bid + BuySL_Points * point,
                       bid - BuyTP_Points * point,      // note: you had -90 before
                       "Sell vs USD");
      }
   }
}