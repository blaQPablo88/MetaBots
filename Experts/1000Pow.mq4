
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
     if (OrdersTotal()<170) 
     {
        if ((currentPrice < movingAverage) && (currentPrice > lastPrice)) 
        {
          //OrderSend (Symbol(),OP_SELL,0.04,Bid,3,0,Bid-150*Point,NULL,0,0,Red);
           OrderSend ("USDCADm",OP_SELL,0.04,USDCADmBid,3,USDCADmBid+250*Point,USDCADmBid-85*Point,NULL,0,0,Red);
           OrderSend ("USDCHFm",OP_SELL,0.04,USDCHFmBid,3,USDCHFmBid+250*Point,USDCHFmBid-85*Point,NULL,0,0,Red);
           OrderSend ("USDJPYm",OP_SELL,0.04,USDJPYmBid,3,USDJPYmBid+250*Point,USDJPYmBid-85*Point,NULL,0,0,Red);
           OrderSend ("USDSEKm",OP_SELL,0.04,USDSEKmBid,3,USDSEKmBid+250*Point,USDSEKmBid-85*Point,NULL,0,0,Red);
           OrderSend ("EURUSDm",OP_BUY,0.06,EURUSDmAsk,3,EURUSDmAsk-300*Point,EURUSDmAsk+70*Point,NULL,0,0,Green);
           OrderSend ("GBPUSDm",OP_BUY,0.06,GBPUSDmAsk,3,GBPUSDmAsk-300*Point,GBPUSDmAsk+70*Point,NULL,0,0,Green);
           OrderSend ("NZDUSDm",OP_BUY,0.06,NZDUSDmAsk,3,NZDUSDmAsk-300*Point,NZDUSDmAsk+70*Point,NULL,0,0,Green);
           OrderSend ("AUDUSDm",OP_BUY,0.06,AUDUSDmAsk,3,AUDUSDmAsk-300*Point,AUDUSDmAsk+70*Point,NULL,0,0,Green);
           OrderSend ("DXY",OP_BUY,0.06,DXYmAsk,3,DXYmAsk-300*Point,DXYmAsk+70*Point,NULL,0,0,Green);
           
           
        }  
     }        
                                                                               
                                                                                          
     //selling                             
     if (OrdersTotal()<170) 
     {
        if ((currentPrice > movingAverage) && (currentPrice < lastPrice)) 
        {                                                              
           //OrderSend (Symbol(),OP_BUY,0.00,Ask,3,0,Ask+150*Point,NULL,0,0,Green); 
           OrderSend ("USDCADm",OP_BUY,0.04,USDCADmAsk,3,USDCADmBid-250*Point,USDCADmAsk+85*Point,NULL,0,0,Green);
           OrderSend ("USDCHFm",OP_BUY,0.04,USDCHFmAsk,3,USDCADmBid-250*Point,USDCHFmAsk+85*Point,NULL,0,0,Green);
           OrderSend ("USDJPYm",OP_BUY,0.04,USDJPYmAsk,3,USDCADmBid-250*Point,USDJPYmAsk+85*Point,NULL,0,0,Green);
           OrderSend ("USDSEKm",OP_BUY,0.04,USDSEKmAsk,3,USDCADmBid-250*Point,USDSEKmAsk+85*Point,NULL,0,0,Green);
           OrderSend ("EURUSDm",OP_SELL,0.06,EURUSDmBid,3,EURUSDmBid+300*Point,EURUSDmBid-90*Point,NULL,0,0,Red);
           OrderSend ("GBPUSDm",OP_SELL,0.06,GBPUSDmBid,3,GBPUSDmBid+300*Point,GBPUSDmBid-90*Point,NULL,0,0,Red);
           OrderSend ("NZDUSDm",OP_SELL,0.06,NZDUSDmBid,3,NZDUSDmBid+300*Point,NZDUSDmBid-90*Point,NULL,0,0,Red);
           OrderSend ("AUDUSDm",OP_SELL,0.06,AUDUSDmBid,3,AUDUSDmBid+300*Point,AUDUSDmBid-90*Point,NULL,0,0,Red);
           OrderSend ("DXYm",OP_SELL,0.06,DXYmBid,3,DXYmBid+300*Point,DXYmBid-90*Point,NULL,0,0,Red);    
        }    
     }                                               
          
       
    Alert(GetLastError());


}
