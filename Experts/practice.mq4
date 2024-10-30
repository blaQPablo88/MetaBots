
void OnTick()
  {
     //calculate ask price 
     double Ask = NormalizeDouble(SymbolInfoDouble(Symbol(),SYMBOL_ASK),Digits);
     double EURUSDmAsk = NormalizeDouble(SymbolInfoDouble("EURUSDm",SYMBOL_ASK),_Digits);
     double GBPUSDmAsk = NormalizeDouble(SymbolInfoDouble("GBPUSDm",SYMBOL_ASK),_Digits);
     double NZDUSDmAsk = NormalizeDouble(SymbolInfoDouble("NZDUSDm",SYMBOL_ASK),_Digits);
     double AUDUSDmAsk = NormalizeDouble(SymbolInfoDouble("AUDUSDm",SYMBOL_ASK),_Digits);
         
     //buying
     if (OrdersTotal()<23) {
         if ( OrderSend (Symbol(),OP_BUY,0.00,Ask,3,0,Ask+150*Point,NULL,0,0,Green) == ) {
                   
            OrderSend ("EURUSDm",OP_BUY,0.01,EURUSDmAsk,3,0,EURUSDmAsk+150*Point,NULL,0,0,Green);
            OrderSend ("GBPUSDm",OP_BUY,0.01,GBPUSDmAsk,3,0,GBPUSDmAsk+150*Point,NULL,0,0,Green);
            OrderSend ("NZDUSDm",OP_BUY,0.01,NZDUSDmAsk,3,0,NZDUSDmAsk+150*Point,NULL,0,0,Green);
            OrderSend ("AUDUSDm",OP_BUY,0.01,AUDUSDmAsk,3,0,AUDUSDmAsk+150*Point,NULL,0,0,Green);
      }

}

