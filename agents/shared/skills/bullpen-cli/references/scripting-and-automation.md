# Scripting and Automation

Use JSON output, jq piping, and batch workflows to automate prediction market operations.

## JSON Output

All commands support `--output json` for machine-readable output:

```bash
bullpen polymarket discover --output json
bullpen polymarket positions --output json
bullpen polymarket price will-bitcoin-hit-100k --output json
```

## Essential Flags for Automation

- `--output json` — Machine-readable output (all commands)
- `--yes` — Skip confirmation prompts (trading commands)
- `--non-interactive` — Disable all interactive prompts (auth)
- `--preview` — Dry-run trade without executing

## Piping with jq

### Extract Market Data

```bash
# Get market slugs from discovery
bullpen polymarket discover --output json | jq -r '.markets[].slug'

# Get prices for specific outcome
bullpen polymarket price will-bitcoin-hit-100k --output json | jq '.outcomes[] | select(.name == "Yes") | .midpoint'

# Filter high-value positions
bullpen polymarket positions --output json | jq '.positions[] | select(.current_value > 100)'
```

### Extract Order Data

```bash
# List open order IDs
bullpen polymarket orders --output json | jq -r '.orders[].id'

# Find orders on a specific market
bullpen polymarket orders --output json | jq '.orders[] | select(.market_slug == "will-bitcoin-hit-100k")'
```

### Extract Trader Data

```bash
# Top 5 traders by P&L
bullpen polymarket data leaderboard --output json | jq '.traders[:5] | .[] | {name, pnl, volume}'

# Smart money signals for a category
bullpen polymarket data smart-money --output json | jq '.signals[] | select(.category == "crypto")'
```

## Batch Operations

### Monitor Multiple Markets

```bash
#!/bin/bash
# Price check across watchlist
bullpen tracker watchlist --output json | jq -r '.markets[].slug' | while read slug; do
  echo "=== $slug ==="
  bullpen polymarket price "$slug" --output json
done
```

### Bulk Cancel Orders

```bash
# Cancel all orders on a market
bullpen polymarket orders --cancel-all --yes

# Cancel specific orders
IDS=$(bullpen polymarket orders --output json | jq -r '.orders[].id' | paste -sd,)
bullpen polymarket orders --cancel "$IDS" --yes
```

### Automated Position Check

```bash
#!/bin/bash
# Check for redeemable positions and redeem
REDEEMABLE=$(bullpen polymarket positions --redeemable --output json | jq '.positions | length')
if [ "$REDEEMABLE" -gt 0 ]; then
  echo "Found $REDEEMABLE redeemable positions, redeeming..."
  bullpen polymarket redeem --yes
fi
```

### Market Screening

```bash
#!/bin/bash
# Find high-volume crypto markets with tight spreads
bullpen polymarket discover crypto --sort volume --min-liquidity 50000 --output json | \
  jq -r '.markets[].slug' | while read slug; do
    PRICE_DATA=$(bullpen polymarket price "$slug" --output json)
    SPREAD=$(echo "$PRICE_DATA" | jq '.outcomes[0].spread // 0')
    if (( $(echo "$SPREAD < 0.05" | bc -l) )); then
      echo "Tight spread ($SPREAD): $slug"
    fi
  done
```

### Portfolio Snapshot

```bash
#!/bin/bash
# Daily portfolio snapshot
DATE=$(date +%Y-%m-%d)
echo "=== Portfolio Snapshot $DATE ==="

echo "--- Balances ---"
bullpen portfolio balances --output json

echo "--- Positions ---"
bullpen polymarket positions --output json | jq '{
  total_positions: (.positions | length),
  total_value: ([.positions[].current_value] | add),
  positions: [.positions[] | {title, outcome, shares: .size, value: .current_value, pnl: .pnl}]
}'

echo "--- Open Orders ---"
bullpen polymarket orders --output json | jq '.orders | length'
```

### Smart Money Following

```bash
#!/bin/bash
# Track top weekly traders
bullpen polymarket data leaderboard --period week --limit 10 --output json | \
  jq -r '.traders[].address' | while read addr; do
    bullpen tracker add "$addr"
    echo "Tracking: $addr"
  done
```

## Authentication

Device auth (RFC 8628) normally opens a browser. For headless or CI environments, use `--no-browser` to get a printable login URL:

```bash
bullpen login --no-browser
# Prints the login URL — open it manually or in a remote browser
```

For fully unattended CI pipelines, pre-authenticate locally and copy the credentials to the CI environment:

```bash
# Authenticate locally, then copy these files to CI:
# ~/.bullpen/credentials.json + ~/.bullpen/keys/turnkey_p256.json
bullpen login
```

## Cron Job Recipes

### Hourly Position Check

```bash
# crontab -e
0 * * * * /usr/local/bin/bullpen polymarket positions --redeemable --output json | jq '.positions | length' >> /var/log/bullpen-redeemable.log
```

### Daily Leaderboard Snapshot

```bash
0 9 * * * /usr/local/bin/bullpen polymarket data leaderboard --period day --output json > /data/leaderboard-$(date +\%Y\%m\%d).json
```

## Error Handling in Scripts

```bash
#!/bin/bash
set -e

# Check auth before trading
if ! bullpen status --output json | jq -e '.account.logged_in' > /dev/null 2>&1; then
  echo "Error: Not authenticated. Run: bullpen login"
  exit 1
fi

# Trade with error handling
if bullpen polymarket buy will-bitcoin-hit-100k Yes 10 --yes --output json 2>/dev/null; then
  echo "Trade successful"
else
  EXIT_CODE=$?
  if [ $EXIT_CODE -eq 3 ]; then
    echo "Trade execution failed — check balance and approvals"
  else
    echo "Unexpected error (exit code: $EXIT_CODE)"
  fi
fi
```

## Rate Limiting

When scripting multiple requests:
- Add 1-2 second delays between API calls in loops
- Use `--output json` to avoid unnecessary formatting overhead
- Batch operations where possible (e.g., `--cancel-all` instead of individual cancels)

## Cross-References

- **Command details**: See `references/discovery-and-research.md`, `references/trading.md`, `references/portfolio-and-orders.md`
- **Account setup for CI**: See `references/getting-started.md`
- **Social monitoring scripts**: See `references/social-and-signals.md`
