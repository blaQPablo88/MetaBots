
void OnTick()
  {

   double currentPrice = Open[0];
   double lastPrice = Open[1];
   
    // Buy
     if (OrdersTotal()<23) {
         OrderSend(Symbol(),OP_BUY,0.02,Ask,3,0,Ask+150*Point,NULL,0,0,Green);
     }
    Alert("Last Price: "+lastPrice+" Current Price: "+currentPrice);
   
}

