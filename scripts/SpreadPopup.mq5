//+------------------------------------------------------------------+
//|                                                  SpreadPopup.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
      double spread = GetSpread(Symbol());
      spread = NormalizeDouble(spread, 0);
      Alert("Spread: " + DoubleToString(spread));
   
  }
  
double GetSpread(string symbol)
{
   // Get bid and ask prices
   double bid = SymbolInfoDouble(symbol, SYMBOL_BID);
   double ask = SymbolInfoDouble(symbol, SYMBOL_ASK);

   // Get point size
   double point = SymbolInfoDouble(symbol, SYMBOL_POINT);

   // Calculate spread in points
   double spread_points = (ask - bid) / point;

   // Determine pip value based on broker digits
   int digits = (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS);
   double pip_value = (digits == 3 || digits == 5) ? 10.0 : 1.0;

   // Spread in pips
   double spread_pips = spread_points / pip_value;

   return(spread_pips);
}
//+------------------------------------------------------------------+
