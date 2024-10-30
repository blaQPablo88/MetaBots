
void OnTick()
  {
     //calculate ask price 
     double Ask = NormalizeDouble(SymbolInfoDouble(Symbol(),SYMBOL_ASK),Digits);
     double EURUSDcAsk = NormalizeDouble(SymbolInfoDouble("EURUSDc",SYMBOL_ASK),_Digits);
     double GBPUSDcAsk = NormalizeDouble(SymbolInfoDouble("GBPUSDc",SYMBOL_ASK),_Digits);
     double NZDUSDcAsk = NormalizeDouble(SymbolInfoDouble("NZDUSDc",SYMBOL_ASK),_Digits);
     double AUDUSDcAsk = NormalizeDouble(SymbolInfoDouble("AUDUSDc",SYMBOL_ASK),_Digits); 
         
     //buying
     if (OrdersTotal()<23) {
        OrderSend (Symbol(),OP_BUY,0.01,Ask,3,0,Ask+150*Point,NULL,0,0,Green);
        OrderSend ("EURUSDc",OP_BUY,0.01,EURUSDcAsk,3,0,EURUSDcAsk+150*Point,NULL,0,0,Green);
        OrderSend ("GBPUSDc",OP_BUY,0.01,GBPUSDcAsk,3,0,GBPUSDcAsk+150*Point,NULL,0,0,Green);
        OrderSend ("NZDUSDc",OP_BUY,0.01,NZDUSDcAsk,3,0,NZDUSDcAsk+150*Point,NULL,0,0,Green);
        OrderSend ("AUDUSDc",OP_BUY,0.01,AUDUSDcAsk,3,0,AUDUSDcAsk+150*Point,NULL,0,0,Green);
      }

}

