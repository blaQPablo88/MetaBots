# MetaBots – Professional MQL4 Expert Advisors

![MetaTrader 4](https://img.shields.io/badge/MetaTrader-4-blue.svg)
![MQL4](https://img.shields.io/badge/Language-MQL4-orange.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

**MetaBots** is a collection of clean, safe, and actively maintained **MetaTrader 4 Expert Advisors (EAs)** and utilities focused on multi-pair forex trading.

All EAs have been refactored with modern MQL4 best practices:
- `#property strict`
- Safe order handling and error logging
- Magic Number-based order management
- New-bar filtering to prevent spam
- Reusable helper functions
- **Integrated emergency 1-Click Close button**


---

## 🚀 Main Expert Advisor

### **Momentum Multi-Pair Trader with Emergency Close** (Recommended)

**Strategy Overview**  
- Uses 15-period SMA of median price + price action (rising/falling).  
- Trades two groups of symbols:  
  - **Weak USD pairs** (`EURUSDm`, `GBPUSDm`, `NZDUSDm`, `AUDUSDm`)  
  - **Strong USD pairs** (`USDCADm`, `USDCHFm`, `USDJPYm`, `USDSEKm`)  

**Key Features**  
- Trades only on new bar (no order spam).  
- Proper per-symbol `_Point` and `_Digits` handling (safe for JPY pairs).  
- **Large red emergency button** on the chart: **"🚨 CLOSE ALL ORDERS & PENDINGS"**.  
- Button safely closes market orders and deletes pending orders with retry logic for common errors (129, 135, 136, 146).  
- Filters by Magic Number (set to `0` to close everything on the account).  
- Full logging and error handling.

**Button Location**  
Top-right corner of the chart. Click once to trigger emergency close.

---

## Other Included / Planned EAs

- **Standalone 1-Click Close** – Original button-only utility.  
- **Advanced Risk-Managed EA** (Trickerless-style) – Dynamic lots, ATR/ADX, news filter, etc. (refactoring in progress).  
- **Trend with DXY Confirmation** – Upcoming version where DXY is used strictly as a filter (not traded).

---

## ⚙️ Installation

1. Download or clone the repository.
2. Open MetaTrader 4 → **File → Open Data Folder**.
3. Copy `.mq4` files from `Experts/` into `MQL4/Experts`.
4. Restart MetaTrader 4 or refresh the Navigator panel.
5. Attach **MomentumWithEmergencyClose.mq4** to any chart (preferably a major pair or DXYm).
6. Adjust inputs (MagicNumber, lot sizes, SL/TP, MaxOrders) as needed.

**Important:** Ensure all "m" suffix symbols (e.g. `EURUSDm`) are added to **Market Watch**.

---

## ⚠️ Risk Warning & Recommendations

- **Always test on a demo account** for at least 4–8 weeks before going live.  
- Start with small lot sizes (0.01 – 0.04).  
- The emergency close button is your safety net — keep the EA attached to at least one chart.  
- Never risk more than 1–2% of your account per trade.  
- Use high-quality tick data for backtesting.  
- **Trading involves substantial risk of loss.** Past performance ≠ future results.

---

## 🔧 Common Input Parameters

| Parameter          | Default   | Description |
|--------------------|-----------|-----------|
| `MagicNumber`      | 123456    | Unique ID for this EA's orders (0 = affect all orders) |
| `MaxOrders`        | 50        | Maximum total open orders allowed |
| `TradeOnNewBar`    | true      | Prevent multiple entries per candle |
| `WeakLots`         | 0.06      | Lot size for weak-USD buys |
| `StrongLots`       | 0.04      | Lot size for strong-USD sells |
| `WeakBuy_SL_Points`| 300       | Stop Loss for weak-USD buys |
| `WeakBuy_TP_Points`| 70        | Take Profit for weak-USD buys |
| `StrongSell_SL_Points` | 250   | Stop Loss for strong-USD sells |
| `StrongSell_TP_Points` | 85    | Take Profit for strong-USD sells |

---

## 📘 Documentation

- Full parameter explanations and strategy rules → `Users_manual.pdf`
- Older notes → `instructions.txt`

---

## 🛠️ Planned Improvements

- DXY used strictly as confirmation filter (no trading DXY)
- Dynamic lot sizing based on account risk %
- London / New York session filter
- Trailing stop & breakeven functionality
- Reusable `include/` files (`TradeUtils.mqh`, `SymbolGroups.mqh`, etc.)
- Push/email notifications on emergency close

---

## 👤 Author

**blaQPablo88** 
MQL4 Developer & Forex Automation Enthusiast  

GitHub: [blaQPablo88](https://github.com/blaQPablo88/MetaBots)

---

## 📜 License

This project is licensed under the **MIT License** – free to use, modify, and distribute with attribution.

---

**Thank you for using MetaBots!**  
The emergency close button gives you peace of mind during volatile moves.  

If you need further customizations (DXY filter, dynamic lots, etc.), feel free to open an issue or contact me.

**Trade safe!** 🚀