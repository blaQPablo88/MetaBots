
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
     double DXYcAsk = NormalizeDouble(SymbolInfoDouble("DXYc",SYMBOL_ASK),_Digits);
     
       
     //calculate bid price
     double Bid = NormalizeDouble(SymbolInfoDouble(Symbol(),SYMBOL_BID),Digits);
     double EURUSDcBid = NormalizeDouble(SymbolInfoDouble("EURUSDc",SYMBOL_BID),Digits);
     double GBPUSDcBid = NormalizeDouble(SymbolInfoDouble("GBPUSDc",SYMBOL_BID),Digits);
     double NZDUSDcBid = NormalizeDouble(SymbolInfoDouble("NZDUSDc",SYMBOL_BID),Digits);
     double AUDUSDcBid = NormalizeDouble(SymbolInfoDouble("AUDUSDc",SYMBOL_BID),Digits); 
     double DXYcBid = NormalizeDouble(SymbolInfoDouble("DXYc",SYMBOL_BID),Digits);
      
     //buying
     if (OrdersTotal()<8) 
     {
        if ((currentPrice > movingAverage) && (currentPrice > lastPrice)) 
        {
           OrderSend ("EURUSDc",OP_BUY,0.01,EURUSDcAsk,3,0,EURUSDcAsk+150*Point,NULL,0,0,Green);
           OrderSend ("GBPUSDc",OP_BUY,0.01,GBPUSDcAsk,3,0,GBPUSDcAsk+150*Point,NULL,0,0,Green);
           OrderSend ("NZDUSDc",OP_BUY,0.01,NZDUSDcAsk,3,0,NZDUSDcAsk+150*Point,NULL,0,0,Green);
           OrderSend ("AUDUSDc",OP_BUY,0.01,AUDUSDcAsk,3,0,AUDUSDcAsk+150*Point,NULL,0,0,Green);
           OrderSend ("DXYc",OP_BUY,0.01,DXYcAsk,3,0,DXYcAsk+150*Point,NULL,0,0,Green);
        }  
     }        
                                                                               
                                                                                          
     //selling                             
     if (OrdersTotal()<8) 
     {
        if ((currentPrice < movingAverage) && (currentPrice < lastPrice)) 
        {                                                              
           OrderSend ("EURUSDc",OP_SELL,0.01,EURUSDcBid,3,0,EURUSDcBid-150*Point,NULL,0,0,Red);
           OrderSend ("GBPUSDc",OP_SELL,0.01,GBPUSDcBid,3,0,GBPUSDcBid-150*Point,NULL,0,0,Red);
           OrderSend ("NZDUSDc",OP_SELL,0.01,NZDUSDcBid,3,0,NZDUSDcBid-150*Point,NULL,0,0,Red);
           OrderSend ("AUDUSDc",OP_SELL,0.01,AUDUSDcBid,3,0,AUDUSDcBid-150*Point,NULL,0,0,Red); 
           OrderSend ("DXYc",OP_SELL,0.01,DXYcBid,3,0,DXYcBid-150*Point,NULL,0,0,Red);   
        }    
     }                                               
          
       
    Alert(GetLastError());


}
