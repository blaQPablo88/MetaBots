//+------------------------------------------------------------------+
//|                                                    beastmode.mq4 |
//|                                                           Kagiso |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Kagiso"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int order;

int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {  
     double movingAverage =iMA(Symbol(),0,15,0,MODE_SMA,PRICE_MEDIAN,0);
     double currentPrice = Open[0];
     double lastPrice = Open[1]; 
        
     
     //calculate ask price 
     double Ask = NormalizeDouble(SymbolInfoDouble(Symbol(),SYMBOL_ASK),Digits);
     double EURUSDcAsk = NormalizeDouble(SymbolInfoDouble("EURUSDc",SYMBOL_ASK),_Digits);
     double GBPUSDcAsk = NormalizeDouble(SymbolInfoDouble("GBPUSDc",SYMBOL_ASK),_Digits);
     double NZDUSDcAsk = NormalizeDouble(SymbolInfoDouble("NZDUSDc",SYMBOL_ASK),_Digits);
     double AUDUSDcAsk = NormalizeDouble(SymbolInfoDouble("AUDUSDc",SYMBOL_ASK),_Digits); 
         
     //calculate bid price
     double Bid = NormalizeDouble(SymbolInfoDouble(Symbol(),SYMBOL_BID),Digits);
     double EURUSDcBid = NormalizeDouble(SymbolInfoDouble("EURUSDc",SYMBOL_BID),Digits);
     double GBPUSDcBid = NormalizeDouble(SymbolInfoDouble("GBPUSDc",SYMBOL_BID),Digits);
     double NZDUSDcBid = NormalizeDouble(SymbolInfoDouble("NZDUSDc",SYMBOL_BID),Digits);
     double AUDUSDcBid = NormalizeDouble(SymbolInfoDouble("AUDUSDc",SYMBOL_BID),Digits);
  
  
     //buying
     if ( (currentPrice > movingAverage) && (currentPrice > lastPrice) )
     if (OrdersTotal()<23) {
        OrderSend (Symbol(),OP_BUY,0.02,Ask,3,0,Ask+150*Point,NULL,0,0,Green);
        OrderSend ("EURUSDc",OP_BUY,0.02,EURUSDcAsk,3,0,EURUSDcAsk+150*Point,NULL,0,0,Green);
        OrderSend ("GBPUSDc",OP_BUY,0.02,GBPUSDcAsk,3,0,GBPUSDcAsk+150*Point,NULL,0,0,Green);
        OrderSend ("NZDUSDc",OP_BUY,0.02,NZDUSDcAsk,3,0,NZDUSDcAsk+150*Point,NULL,0,0,Green);
        OrderSend ("AUDUSDc",OP_BUY,0.02,AUDUSDcAsk,3,0,AUDUSDcAsk+150*Point,NULL,0,0,Green);
      }
      
     //selling
     if ( (currentPrice > movingAverage) && (currentPrice > lastPrice) )
     if (OrdersTotal()<23) {
        OrderSend (Symbol(),OP_SELL,0.02,Bid,3,0,Bid-150*Point,NULL,0,0,Red);
        OrderSend ("EURUSDc",OP_SELL,0.02,EURUSDcBid,3,0,EURUSDcBid-150*Point,NULL,0,0,Red);
        OrderSend ("GBPUSDc",OP_SELL,0.02,GBPUSDcBid,3,0,GBPUSDcBid-150*Point,NULL,0,0,Red);
        OrderSend ("NZDUSDc",OP_SELL,0.02,NZDUSDcBid,3,0,NZDUSDcBid-150*Point,NULL,0,0,Red);
        OrderSend ("AUDUSDc",OP_SELL,0.02,AUDUSDcBid,3,0,AUDUSDcBid-150*Point,NULL,0,0,Red);
      }
}