
void OnTick()
  {
//---
      
      double movingAverage =iMA(Symbol(),0,15,0,MODE_SMA,PRICE_MEDIAN,0);
      double currentPrice = Open[0];
      double lastPrice = Open[1];
      
      //buy
      if ((currentPrice < movingAverage) && (currentPrice > lastPrice)) 
      {
         if (OrdersTotal()<10000) 
         {
            OrderSend(Symbol(),OP_BUY,0.04,Ask,3,0,Ask+150*Point,NULL,0,0,NULL);
         }  
      }
      
      //sell
      else if ((currentPrice > movingAverage) && (currentPrice < lastPrice)) 
      {
         if (OrdersTotal()<9000) 
         {
            OrderSend(Symbol(),OP_SELL,0.04,Bid,3,0,Bid-150*Point,NULL,0,0,NULL);
         }
      }
      
      Alert(currentPrice);
      Alert(lastPrice);
      Alert(GetLastError());
      
}
//+------------------------------------------------------------------+
