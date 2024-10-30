
void OnTick()
  {
//---
   
   double currentPrice = Open[0];
   double lastPrice = Open[1];
   
    // Sell
     if (OrdersTotal()<14) {
         OrderSend(Symbol(),OP_SELL,0.19,Bid,3,0,Bid-60*Point,NULL,0,0,NULL);
     }
    Alert("Last Price: "+lastPrice+" Current Price: "+currentPrice);
}
//+------------------------------------------------------------------+
