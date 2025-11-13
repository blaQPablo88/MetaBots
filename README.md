# MetaBots – MQL4 Expert Advisors Collection

MetaBots is a collection of custom-built **MetaTrader 4 Expert Advisors (EAs)** and **utility scripts** designed to automate trading actions, manage positions, and execute strategy logic across forex pairs.  
This repository contains multiple MQL4 bots I’ve built over time, including:

- **1-Click Close EA** – Close all market + pending orders with a single chart button  
- **Momentum Multi-Pair Trader** – Strategy using price action relative to a moving average  
- **Multi-Pair Cross-Trend Trader** – Multi-symbol MA-based system  
- **Advanced Risk-Managed EA** *(Trickerless 7.22-style)* – Dynamic lot sizing, safety exits, trend detection, ATR/ADX filtering, and calendar-based control

---

## 📁 **Included Bots**

---

## ### **1. 1-Click Close EA (`1 click close.mq4`)**

A utility EA that creates a **button on the chart** that instantly:

- closes all **market orders**
- deletes all **pending orders**
- retries automatically if price changes or spreads cause temporary errors
- handles errors like:
  - invalid price (129)
  - requotes (135)
  - off quotes (136)
  - trade context busy (146)

### **Features**
- Chart button: **“Close Market Orders and Delete Pending Orders”**
- Cleans everything with one click  
- Safe retry logic  
- Supports Magic Number filtering

---

## ### **2. Multi-Pair Moving Average Strategy EA**

This EA trades multiple pairs (EURUSDc, GBPUSDc, NZDUSDc, AUDUSDc) using:

- 15-period SMA  
- Price crossover logic  
- Momentum detection using previous candle  
- Auto Buy/Sell based on **current price vs MA** and **current vs last price**  
- Position cap (max 7 open orders)

### Logic:
**Buy when:**
- `currentPrice < movingAverage`
- `currentPrice < lastPrice`

**Sell when:**
- `currentPrice > movingAverage`
- `currentPrice > lastPrice`

---

## ### **3. Multi-Pair Trend-Aligned Grid EA (Expanded Version)**

An expanded version that includes DXY and sends trades across five symbols:

- **EURUSDc**
- **GBPUSDc**
- **NZDUSDc**
- **AUDUSDc**
- **DXYc**

### Features
- Max 8 orders  
- Direction determined by SMA and price movement  
- Static TP/SL based on points  
- Very lightweight trend-following engine

---

## ### **4. Advanced Risk-Managed EA (Trickerless-style system)**

A highly configurable EA focusing on:

### **Risk Controls**
- Safe spread check  
- Daily growth limits  
- Relative stop logic  
- Profit locking & basket profit control  
- Margin-aware lot sizing  
- Backup lots & news-lots  
- ATR-based dynamic slippage  
- ADX trend detection  
- MA cross confirmation  
- Hedge permissions  
- Calendar-based pause logic  
- Daily refresh & news window filters

### **Built-in Parameters**
- **Safety Controls**  
- **Trade Limits**  
- **Growth Constraints**  
- **Profit & Stop Management**  
- **Indicator Filters (ATR, ADX, MA)**  
- **Margin Management**  
- **History-based logic**  
- **Back-system triggers**

This EA is designed for more advanced portfolio-level management.

---

## 🚀 Installation

1. Open **MetaTrader 4**
2. Go to:  
   **File → Open Data Folder**
3. Navigate to:  
   `MQL4/Experts`
4. Copy the `.mq4` files into that folder
5. Restart MT4 or refresh the Navigator panel
6. Attach the EA to any chart you want to run it on

---

## 🧪 Backtesting

1. Open **Strategy Tester**  
2. Select an EA from the MetaBots list  
3. Choose symbol + timeframe  
4. Configure spread and modelling quality  
5. Click **Start**

For best accuracy, use **tick data** (e.g., Dukascopy import via TickStory / Tick Data Suite).

---

## ⚠️ Disclaimer

These Expert Advisors are shared **for educational and research purposes**.  
Past performance does not guarantee future results.  
Use in a demo environment before applying to live accounts.

---

## 👤 Author

**Kagiso**  
MQL4 Developer & Automation Enthusiast  
GitHub: *your profile link*

---

## 📬 Want help improving the bots?

If you want to:

- rewrite these into **OOP-style MQL4**
- add trailing stop systems  
- add dashboards  
- add logging  
- port to **MQL5**

Just let me know — I can help add them to the repo.

