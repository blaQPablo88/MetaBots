//+------------------------------------------------------------------+
//|                                                  SymbolGroups.mqh |
//|                  Reusable symbol groups for MetaBots              |
//+------------------------------------------------------------------+
#property copyright "blaQPablo88"
#property version   "1.00"
#property strict

//--- Weak USD pairs (buy when dollar is weakening)
string WeakUSD_Symbols[]   = {"EURUSDm", "GBPUSDm", "NZDUSDm", "AUDUSDm"};

//--- Strong USD pairs (sell when dollar is strengthening)
string StrongUSD_Symbols[] = {"USDCADm", "USDCHFm", "USDJPYm", "USDSEKm"};

//--- Lot sizes
double WeakLots   = 0.06;
double StrongLots = 0.04;

//--- SL/TP in points
int WeakBuy_SL_Points     = 300;
int WeakBuy_TP_Points     = 70;
int StrongSell_SL_Points  = 250;
int StrongSell_TP_Points  = 85;

//+------------------------------------------------------------------+
//| Optional: DXY symbol (for confirmation)                          |
//+------------------------------------------------------------------+
string DXY_Symbol = "DXYm";