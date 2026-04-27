# Discovery and Research

Find, search, and analyze prediction markets on Polymarket. All commands in this section work without authentication.

## Discover Markets

Browse markets with curated lenses and filters:

```bash
bullpen polymarket discover [OPTIONS] [LENS]
```

**Lenses** (first argument):
- `all` (default) — all active markets
- `sports` — sports markets
- `crypto` — cryptocurrency markets
- `traders` — popular among traders
- `walletscope` — markets relevant to your wallet (requires `--address`)
- `flow` — unusual trading flow (requires `--address`)
- `eventscope` — event-level grouping

**Key filters:**
```bash
# High-volume markets
bullpen polymarket discover --sort volume --min-liquidity 100000

# Sports markets ending soon
bullpen polymarket discover sports --sort ending-soon

# Crypto markets with tight odds
bullpen polymarket discover crypto --min-odds 40 --sort volume

# Limit results
bullpen polymarket discover --limit 50

# Filter by category
bullpen polymarket discover --category politics
```

**Sort options**: `volume`, `volume24h`, `liquidity`, `newest`, `ending-soon`

**Status filter**: `--status active` (default) or `--status closed`

## Search Markets and Traders

```bash
bullpen polymarket search [OPTIONS] <QUERY>
```

```bash
# Search markets
bullpen polymarket search "bitcoin"

# Search only markets
bullpen polymarket search "bitcoin" --type market

# Search only traders
bullpen polymarket search "0x1234" --type user

# Limit results
bullpen polymarket search "election" --limit 10 --status active

# Search by Polymarket URL (extracts slug automatically)
bullpen polymarket search "https://polymarket.com/event/bitcoin-100k"
```

**Type filter**: `all` (default), `market`, `user`

**Smart features:**
- **URL detection**: Paste a full Polymarket URL — the slug is extracted automatically
- **Smart retry**: If no results are found for market searches, the query is simplified (numbers/special chars stripped) and retried. The output shows "No results for X. Showing results for Y instead."
- **Market slugs**: Search results include market slugs below each row for easy copy-paste into trading commands
- **Outcome aliases**: When trading, `Y`/`N`, `True`/`False`, `1`/`0` all work as aliases for `Yes`/`No`

## Event Details

Get comprehensive info about an event (may contain multiple markets):

```bash
bullpen polymarket event <SLUG>
```

```bash
bullpen polymarket event will-bitcoin-hit-100k
bullpen polymarket event will-bitcoin-hit-100k --output json
```

Returns: event title, description, all outcomes with current prices, end date, volume, liquidity.

## Market Details

Get detailed info about a specific market:

```bash
bullpen polymarket market <SLUG>
```

```bash
bullpen polymarket market will-bitcoin-hit-100k
bullpen polymarket market will-bitcoin-hit-100k --output json
```

## List and Filter Markets

Browse markets with filters:

```bash
bullpen polymarket markets [OPTIONS]
```

```bash
bullpen polymarket markets --status active --sort volume --limit 20
bullpen polymarket markets --status closed
```

## Price Check

Quick price for a market (midpoint, last trade, bid/ask, spread):

```bash
bullpen polymarket price <SLUG> [OUTCOME]
```

```bash
# All outcomes
bullpen polymarket price will-bitcoin-hit-100k

# Specific outcome
bullpen polymarket price will-bitcoin-hit-100k Yes

# JSON for scripting
bullpen polymarket price will-bitcoin-hit-100k --output json
```

## Price History

Historical prices for an outcome:

```bash
bullpen polymarket price-history <SLUG> <OUTCOME> [OPTIONS]
```

```bash
bullpen polymarket price-history will-bitcoin-hit-100k Yes
bullpen polymarket price-history will-bitcoin-hit-100k Yes --interval 1h
```

**Intervals**: `1h`, `6h`, `1d`, `1w`

## Recent Trades

View recent trades on a market:

```bash
bullpen polymarket trades <SLUG>
```

```bash
bullpen polymarket trades will-bitcoin-hit-100k --output json
```

## Top Holders

View top position holders for a market:

```bash
bullpen polymarket holders <SLUG>
```

```bash
bullpen polymarket holders will-bitcoin-hit-100k --output json
```

## Tags and Categories

Browse available market tags:

```bash
bullpen polymarket tags
bullpen polymarket tags --output json
```

## Series

Browse event series (recurring events):

```bash
bullpen polymarket series
bullpen polymarket series --output json
```

## Smart Money Signals

View aggregated smart money activity:

```bash
bullpen polymarket data smart-money [OPTIONS]
```

```bash
bullpen polymarket data smart-money
bullpen polymarket data smart-money --output json
```

Signal types: aggregated activity, top trader movements, new wallet activity.

## Trader Profiles

Look up a trader's stats:

```bash
bullpen polymarket data profile <ADDRESS>
```

```bash
bullpen polymarket data profile 0x1234...abcd --output json
```

Returns: volume, P&L, win rate, number of predictions, account age.

## Open Interest and Volume

```bash
# Open interest for a market
bullpen polymarket data open-interest <CONDITION_ID>

# Live volume for an event
bullpen polymarket data volume <SLUG>
```

## Research Workflow Recipe

Combine commands for deep market research:

```bash
# 1. Find trending markets
bullpen polymarket discover --sort volume --limit 5 --output json

# 2. Drill into a specific event
bullpen polymarket event <SLUG> --output json

# 3. Check current pricing
bullpen polymarket price <SLUG> --output json

# 4. Review price history
bullpen polymarket price-history <SLUG> Yes --interval 1d

# 5. See who's trading
bullpen polymarket trades <SLUG> --output json

# 6. Check top holders
bullpen polymarket holders <SLUG> --output json

# 7. Check smart money signals
bullpen polymarket data smart-money --output json

# 8. Look up a specific trader
bullpen polymarket data profile <ADDRESS> --output json
```

## Cross-References

- **Ready to trade?** See `references/trading.md`
- **Track positions after trading**: See `references/portfolio-and-orders.md`
- **Follow smart money traders**: See `references/social-and-signals.md`
- **Automate research with scripts**: See `references/scripting-and-automation.md`
