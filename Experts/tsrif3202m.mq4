
void OnTick() 
   {
     double movingAverage =iMA(Symbol(),0,15,0,MODE_SMA,PRICE_MEDIAN,0);
     double currentPrice = Open[0];
     double lastPrice = Open[1];
      
     
     
     //calculate ask price 
     double Ask = NormalizeDouble(SymbolInfoDouble(Symbol(),SYMBOL_ASK),Digits);
     double EURUSDmAsk = NormalizeDouble(SymbolInfoDouble("EURUSDm",SYMBOL_ASK),_Digits);
     double GBPUSDmAsk = NormalizeDouble(SymbolInfoDouble("GBPUSDm",SYMBOL_ASK),_Digits);
     double NZDUSDmAsk = NormalizeDouble(SymbolInfoDouble("NZDUSDm",SYMBOL_ASK),_Digits);
     double AUDUSDmAsk = NormalizeDouble(SymbolInfoDouble("AUDUSDm",SYMBOL_ASK),_Digits);
     double USDCADmAsk = NormalizeDouble(SymbolInfoDouble("USDCADm",SYMBOL_ASK),_Digits);
     double USDCHFmAsk = NormalizeDouble(SymbolInfoDouble("USDCHFm",SYMBOL_ASK),_Digits);
     double USDJPYmAsk = NormalizeDouble(SymbolInfoDouble("USDJPYm",SYMBOL_ASK),_Digits);
     double USDSEKmAsk = NormalizeDouble(SymbolInfoDouble("USDSEKm",SYMBOL_ASK),_Digits);
     double DXYmAsk = NormalizeDouble(SymbolInfoDouble("DXYm",SYMBOL_ASK),_Digits);   
     //calculate bid price
     double Bid = NormalizeDouble(SymbolInfoDouble(Symbol(),SYMBOL_BID),Digits);
     double EURUSDmBid = NormalizeDouble(SymbolInfoDouble("EURUSDm",SYMBOL_BID),Digits);
     double GBPUSDmBid = NormalizeDouble(SymbolInfoDouble("GBPUSDm",SYMBOL_BID),Digits);
     double NZDUSDmBid = NormalizeDouble(SymbolInfoDouble("NZDUSDm",SYMBOL_BID),Digits);
     double AUDUSDmBid = NormalizeDouble(SymbolInfoDouble("AUDUSDm",SYMBOL_BID),Digits);
     double USDCADmBid = NormalizeDouble(SymbolInfoDouble("USDCADm",SYMBOL_BID),Digits);
     double USDCHFmBid = NormalizeDouble(SymbolInfoDouble("USDCHFm",SYMBOL_BID),Digits);
     double USDJPYmBid = NormalizeDouble(SymbolInfoDouble("USDJPYm",SYMBOL_BID),Digits);
     double USDSEKmBid = NormalizeDouble(SymbolInfoDouble("USDSEKm",SYMBOL_BID),Digits); 
     double DXYmBid = NormalizeDouble(SymbolInfoDouble("DXYm",SYMBOL_BID),Digits);
      
     //buying
     if (OrdersTotal()<300) {
        if ((currentPrice > movingAverage) && (currentPrice > lastPrice)) {
           OrderSend ("USDCADm",OP_SELL,0.01,USDCADmBid,3,0,USDCADmBid-90*Point,NULL,0,0,Red);
           OrderSend ("USDCHFm",OP_SELL,0.01,USDCHFmBid,3,0,USDCHFmBid-90*Point,NULL,0,0,Red);
           OrderSend ("USDJPYm",OP_SELL,0.01,USDJPYmBid,3,0,USDJPYmBid-90*Point,NULL,0,0,Red);
           OrderSend ("USDSEKm",OP_SELL,0.00,USDSEKmBid,3,0,USDSEKmBid-90*Point,NULL,0,0,Red);
           OrderSend ("EURUSDm",OP_BUY,0.01,EURUSDmAsk,3,0,EURUSDmAsk+90*Point,NULL,0,0,Green);
           OrderSend ("GBPUSDm",OP_BUY,0.01,GBPUSDmAsk,3,0,GBPUSDmAsk+90*Point,NULL,0,0,Green);
           OrderSend ("NZDUSDm",OP_BUY,0.01,NZDUSDmAsk,3,0,NZDUSDmAsk+90*Point,NULL,0,0,Green);
           OrderSend ("AUDUSDm",OP_BUY,0.01,AUDUSDmAsk,3,0,AUDUSDmAsk+90*Point,NULL,0,0,Green);
           OrderSend ("DXY",OP_BUY,0.01,DXYmAsk,3,0,DXYmAsk+90*Point,NULL,0,0,Green);
           
           
        }  
     }        
                                                                               
                                                                                          
     //selling                             
     if (OrdersTotal()<300) {
        if ((currentPrice < movingAverage) && (currentPrice < lastPrice)) { 
           OrderSend ("USDCADm",OP_BUY,0.01,USDCADmAsk,3,0,USDCADmAsk+90*Point,NULL,0,0,Green);
           OrderSend ("USDCHFm",OP_BUY,0.01,USDCHFmAsk,3,0,USDCHFmAsk+90*Point,NULL,0,0,Green);
           OrderSend ("USDJPYm",OP_BUY,0.01,USDJPYmAsk,3,0,USDJPYmAsk+90*Point,NULL,0,0,Green);
           OrderSend ("USDSEKm",OP_BUY,0.00,USDSEKmAsk,3,0,USDSEKmAsk+90*Point,NULL,0,0,Green);
           OrderSend ("EURUSDm",OP_SELL,0.01,EURUSDmBid,3,0,EURUSDmBid-90*Point,NULL,0,0,Red);
           OrderSend ("GBPUSDm",OP_SELL,0.01,GBPUSDmBid,3,0,GBPUSDmBid-90*Point,NULL,0,0,Red);
           OrderSend ("NZDUSDm",OP_SELL,0.01,NZDUSDmBid,3,0,NZDUSDmBid-90*Point,NULL,0,0,Red);
           OrderSend ("AUDUSDm",OP_SELL,0.01,AUDUSDmBid,3,0,AUDUSDmBid-90*Point,NULL,0,0,Red);
           OrderSend ("DXYm",OP_SELL,0.01,DXYmBid,3,0,DXYmBid-90*Point,NULL,0,0,Red);     
        }    
     }                                               
          
       
    Alert(GetLastError());


}
