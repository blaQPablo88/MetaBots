
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
           OrderSend ("EURUSDc",OP_BUY,0.20,EURUSDcAsk,3,EURUSDcAsk-450*Point,EURUSDcAsk+45*Point,NULL,0,0,Green);
           //OrderSend ("GBPUSDc",OP_BUY,0.16,GBPUSDcAsk,3,GBPUSDcAsk-450*Point,GBPUSDcAsk+45*Point,NULL,0,0,Green);
           //OrderSend ("NZDUSDc",OP_BUY,0.1,NZDUSDcAsk,3,NZDUSDcAsk-450*Point,NZDUSDcAsk+45*Point,NULL,0,0,Green);
           //OrderSend ("AUDUSDc",OP_BUY,0.1,AUDUSDcAsk,3,AUDUSDcAsk-450*Point,AUDUSDcAsk+45*Point,NULL,0,0,Green);
           OrderSend ("DXYc",OP_BUY,0.03,DXYcAsk,3,DXYcAsk-450*Point,DXYcAsk+45*Point,NULL,0,0,Green);
        }  
     }        
                                                                               
                                                                                          
     //selling                             
     if (OrdersTotal()<8) 
     {
        if ((currentPrice < movingAverage) && (currentPrice < lastPrice)) 
        {                                                              
           OrderSend ("EURUSDc",OP_SELL,0.20,EURUSDcBid,3,EURUSDcBid+450*Point,EURUSDcBid-45*Point,NULL,0,0,Red);
           //OrderSend ("GBPUSDc",OP_SELL,0.16,GBPUSDcBid,3,GBPUSDcBid+450*Point,GBPUSDcBid-45*Point,NULL,0,0,Red);
           //OrderSend ("NZDUSDc",OP_SELL,0.1,NZDUSDcBid,3,NZDUSDcBid+450*Point,NZDUSDcBid-45*Point,NULL,0,0,Red);
           //OrderSend ("AUDUSDc",OP_SELL,0.1,AUDUSDcBid,3,AUDUSDcBid+450*Point,AUDUSDcBid-45*Point,NULL,0,0,Red); 
           OrderSend ("DXYc",OP_SELL,0.03,DXYcBid,3,DXYcBid+450*Point,DXYcBid-150*Point,NULL,0,0,Red);   
        }    
     }                                               
          
       
    Alert(GetLastError());


}
