# Portfolio and Orders

View positions, manage orders, track activity, and maintain your watchlist on Polymarket.

## Orderbook

```bash
# View live orderbook depth
bullpen polymarket orderbook <SLUG>
bullpen polymarket orderbook <SLUG> --outcome Yes --depth 20
```

## Positions

View your active prediction market positions:

```bash
bullpen polymarket positions [OPTIONS]
```

```bash
# Active positions (default)
bullpen polymarket positions

# Closed positions
bullpen polymarket positions --closed

# Only redeemable positions (resolved markets)
bullpen polymarket positions --redeemable

# Another wallet's positions
bullpen polymarket positions --address 0x1234...abcd

# JSON for scripting
bullpen polymarket positions --output json
```

Shows: market title, outcome, shares held, average entry price, current price, unrealized P&L, ROE, current value.

Positions now show avg entry price, unrealized P&L, and ROE enrichment.

## Open Orders

View your current open orders:

```bash
bullpen polymarket orders [OPTIONS]
```

```bash
# View open orders
bullpen polymarket orders

# JSON output
bullpen polymarket orders --output json
```

Shows: market, outcome, side (buy/sell), price, shares, fill percentage, status (Open/Partial/Filled), expiration type, order ID.

## Trade History

View past trades:

```bash
bullpen polymarket orders --history
```

```bash
# Your trade history
bullpen polymarket orders --history

# Another address's history
bullpen polymarket orders --history --address 0x1234...abcd

# JSON output
bullpen polymarket orders --history --output json
```

## Cancel Orders

```bash
# Cancel a single order
bullpen polymarket orders --cancel <ORDER_ID>

# Cancel multiple orders (comma-separated)
bullpen polymarket orders --cancel <ID1>,<ID2>,<ID3>

# Cancel ALL open orders
bullpen polymarket orders --cancel-all --yes

# Cancel all orders on a specific market
bullpen polymarket orders --cancel-market <CONDITION_ID> --yes
```

Cancel output lists each cancelled order ID. If some orders fail to cancel, both successes and failures are shown separately. The process exits with code 1 on partial failure.

## Activity History

View comprehensive activity (trades, redemptions, rewards, etc.):

```bash
bullpen polymarket activity [OPTIONS]
```

```bash
# All activity
bullpen polymarket activity

# Filter by type
bullpen polymarket activity --type trade
bullpen polymarket activity --type redeem
bullpen polymarket activity --type reward

# Filter by side
bullpen polymarket activity --side buy

# Filter by date range
bullpen polymarket activity --start 2026-01-01 --end 2026-02-01

# Filter by market
bullpen polymarket activity --market <CONDITION_ID>

# Sort and limit
bullpen polymarket activity --sort timestamp --limit 100

# JSON output
bullpen polymarket activity --output json
```

**Activity types**: `trade`, `split`, `merge`, `redeem`, `reward`, `conversion`, `deposit`, `withdrawal`, `yield`, `maker_rebate`

## Watchlist

Manage a watchlist of markets you're tracking:

```bash
bullpen tracker watchlist [OPTIONS]
```

```bash
# View watchlist
bullpen tracker watchlist

# Add a market
bullpen tracker watchlist add will-bitcoin-hit-100k

# Remove a market
bullpen tracker watchlist remove will-bitcoin-hit-100k

# JSON output
bullpen tracker watchlist --output json
```

Watchlist is synced server-side across devices.

## Portfolio Management Workflow

Complete portfolio monitoring flow:

```bash
# 1. Check all positions
bullpen polymarket positions --output json

# 2. Check for redeemable positions
bullpen polymarket positions --redeemable

# 3. Redeem any resolved positions
bullpen polymarket redeem --yes

# 4. Review open orders
bullpen polymarket orders --output json

# 5. Review recent activity
bullpen polymarket activity --type trade --limit 10

# 6. Check overall balances
bullpen portfolio balances
```

## Cross-References

- **Find new markets**: See `references/discovery-and-research.md`
- **Execute trades**: See `references/trading.md`
- **Track other traders**: See `references/social-and-signals.md`
- **Automate monitoring**: See `references/scripting-and-automation.md`
