
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
     if ((currentPrice < movingAverage) && (currentPrice < lastPrice))
     if (OrdersTotal()<7) {
        //OrderSend (Symbol(),OP_BUY,0.01,Ask,3,0,Ask+150*Point,NULL,0,0,Green);
        OrderSend ("EURUSDc",OP_BUY,0.29,EURUSDcAsk,3,EURUSDcAsk-300*Point,EURUSDcAsk+45*Point,NULL,0,0,Green);
        OrderSend ("GBPUSDc",OP_BUY,0.21,GBPUSDcAsk,3,GBPUSDcAsk-300*Point,GBPUSDcAsk+45*Point,NULL,0,0,Green);
        //OrderSend ("GBPUSDc",OP_BUY,0.01,GBPUSDcAsk,3,0,GBPUSDcAsk+150*Point,NULL,0,0,Green);
        //OrderSend ("NZDUSDc",OP_BUY,0.01,NZDUSDcAsk,3,0,NZDUSDcAsk+150*Point,NULL,0,0,Green);
        //OrderSend ("AUDUSDc",OP_BUY,0.01,AUDUSDcAsk,3,0,AUDUSDcAsk+150*Point,NULL,0,0,Green);
      }
      
     //selling
     if ((currentPrice > movingAverage) && (currentPrice > lastPrice))
     if (OrdersTotal()<7) {
        //OrderSend (Symbol(),OP_SELL,0.01,Bid,3,0,Bid-150*Point,NULL,0,0,Red);
        OrderSend ("EURUSDc",OP_SELL,0.29,EURUSDcBid,3,EURUSDcBid+300*Point,EURUSDcBid-45*Point,NULL,0,0,Red);
        OrderSend ("GBPUSDc",OP_SELL,0.21,GBPUSDcBid,3,GBPUSDcBid+300*Point,GBPUSDcBid-45*Point,NULL,0,0,Red);
        //OrderSend ("EURUSDc",OP_SELL,0.01,EURUSDcBid,3,0,EURUSDcBid-150*Point,NULL,0,0,Red);
        //OrderSend ("GBPUSDc",OP_SELL,0.01,GBPUSDcBid,3,0,GBPUSDcBid-150*Point,NULL,0,0,Red);
        //OrderSend ("NZDUSDc",OP_SELL,0.01,NZDUSDcBid,3,0,NZDUSDcBid-150*Point,NULL,0,0,Red);
        //OrderSend ("AUDUSDc",OP_SELL,0.01,AUDUSDcBid,3,0,AUDUSDcBid-150*Point,NULL,0,0,Red);
      }
      
             
}
   


