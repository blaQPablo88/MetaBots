
void OnTick()
  {
     //calculate bid price
     double Bid = NormalizeDouble(SymbolInfoDouble(Symbol(),SYMBOL_BID),Digits);
     double EURUSDcBid = NormalizeDouble(SymbolInfoDouble("EURUSDc",SYMBOL_BID),Digits);
     double GBPUSDcBid = NormalizeDouble(SymbolInfoDouble("GBPUSDc",SYMBOL_BID),Digits);
     double NZDUSDcBid = NormalizeDouble(SymbolInfoDouble("NZDUSDc",SYMBOL_BID),Digits);
     double AUDUSDcBid = NormalizeDouble(SymbolInfoDouble("AUDUSDc",SYMBOL_BID),Digits);
  
     //selling
     if (OrdersTotal()<23) {
        OrderSend (Symbol(),OP_SELL,0.01,Bid,3,0,Bid-150*Point,NULL,0,0,Red);
        OrderSend ("EURUSDc",OP_SELL,0.01,EURUSDcBid,3,0,EURUSDcBid-150*Point,NULL,0,0,Red);
        OrderSend ("GBPUSDc",OP_SELL,0.01,GBPUSDcBid,3,0,GBPUSDcBid-150*Point,NULL,0,0,Red);
        OrderSend ("NZDUSDc",OP_SELL,0.01,NZDUSDcBid,3,0,NZDUSDcBid-150*Point,NULL,0,0,Red);
        OrderSend ("AUDUSDc",OP_SELL,0.01,AUDUSDcBid,3,0,AUDUSDcBid-150*Point,NULL,0,0,Red);
      }
      
}

