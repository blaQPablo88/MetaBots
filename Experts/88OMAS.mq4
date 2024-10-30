
void OnTick()
  { 
   double movingAverage =iMA(Symbol(),0,15,0,MODE_SMA,PRICE_MEDIAN,0);
   double currentPrice = Open[0];
   double lastPrice = Open[1];
   
   //buy order
   if ((currentPrice > movingAverage) && (currentPrice > lastPrice)) 
   {
      OrderSend(Symbol(),OP_BUY,0.13,currentPrice,0,NULL,NULL,NULL,0,0,NULL);
   }
   
   
   //sell order
   else if ((currentPrice < movingAverage) && (currentPrice < lastPrice)) 
   {
      OrderSend(Symbol(),OP_SELL,0.15,currentPrice,0,NULL,NULL,NULL,0,0,NULL);
   }
   
   Alert(currentPrice);
   Alert(lastPrice);
   Alert(GetLastError());
   
  }
//+------------------------------------------------------------------+
