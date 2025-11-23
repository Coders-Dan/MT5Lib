//+------------------------------------------------------------------+
//|                                                MultiOrder.mq5    |
//+------------------------------------------------------------------+
#property strict
#property script_show_inputs

#include <Trade/Trade.mqh>
CTrade trade;

//--- Input parameters
input int      NumberOfOrders = 1;            // Number of orders to open
input ENUM_ORDER_TYPE OrderType = ORDER_TYPE_BUY; // Order type
input double   LotSize = 0.10;                // Lot size
input double   Price = 0.0;                   // Price for pending orders
input double   StopLoss = 0.0;                // Stop Loss
input double   TakeProfit = 0.0;              // Take Profit
input int      Slippage = 5;                  // Slippage

//+------------------------------------------------------------------+
//| Script program start function                                   |
//+------------------------------------------------------------------+
void OnStart()
{
   if(NumberOfOrders <= 0)
   {
      Print("Invalid Number of Orders");
      return;
   }

   for(int i = 0; i < NumberOfOrders; i++)
   {
      bool result = false;

      switch(OrderType)
      {
         case ORDER_TYPE_BUY:
            result = trade.Buy(LotSize, NULL, 0, StopLoss, TakeProfit, "MultiOrder Buy");
            break;

         case ORDER_TYPE_SELL:
            result = trade.Sell(LotSize, NULL, 0, StopLoss, TakeProfit, "MultiOrder Sell");
            break;

         case ORDER_TYPE_BUY_LIMIT:
            result = trade.BuyLimit(LotSize, Price, NULL, StopLoss, TakeProfit, ORDER_TIME_GTC, 0, "MultiOrder Buy Limit");
            break;

         case ORDER_TYPE_SELL_LIMIT:
            result = trade.SellLimit(LotSize, Price, NULL, StopLoss, TakeProfit, ORDER_TIME_GTC, 0, "MultiOrder Sell Limit");
            break;

         case ORDER_TYPE_BUY_STOP:
            result = trade.BuyStop(LotSize, Price, NULL, StopLoss, TakeProfit, ORDER_TIME_GTC, 0, "MultiOrder Buy Stop");
            break;

         case ORDER_TYPE_SELL_STOP:
            result = trade.SellStop(LotSize, Price, NULL, StopLoss, TakeProfit, ORDER_TIME_GTC, 0, "MultiOrder Sell Stop");
            break;

         default:
            Print("Invalid order type selected.");
            return;
      }

      if(!result)
      {
         Print("Order ", i+1, " failed. Error: ", GetLastError());
      }
      else
      {
         Print("Order ", i+1, " placed successfully.");
      }
   }
}
//+------------------------------------------------------------------+
