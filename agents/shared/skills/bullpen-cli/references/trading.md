# Trading

Buy, sell, place limit orders, redeem resolved positions, and manage funds on Polymarket. All trading commands require authentication (`bullpen login`).

## Market Buy

Buy shares at the current market price:

```bash
bullpen polymarket buy [OPTIONS] <MARKET_SLUG> <OUTCOME> <AMOUNT_USD>
```

```bash
# Buy $10 of Yes shares
bullpen polymarket buy will-bitcoin-hit-100k Yes 10

# Skip confirmation (for automation)
bullpen polymarket buy will-bitcoin-hit-100k Yes 10 --yes

# Preview without executing
bullpen polymarket buy will-bitcoin-hit-100k Yes 10 --preview

# JSON output
bullpen polymarket buy will-bitcoin-hit-100k Yes 10 --yes --output json
```

**Arguments:**
- `MARKET_SLUG` — Market slug (e.g., `will-bitcoin-hit-100k`). If the slug is wrong, the CLI shows "Did you mean?" suggestions.
- `OUTCOME` — Outcome name (`Yes`, `No`, or specific outcome text). Aliases work: `Y`/`N`, `True`/`False`, `1`/`0`.
- `AMOUNT_USD` — Dollar amount to spend

**Key flags:**
- `--yes` — Skip confirmation prompt (required for automation)
- `--preview` — Show order preview without executing

**Multi-market events:** When an event contains multiple markets, the CLI auto-selects the highest-volume active market and shows a warning listing all alternatives. JSON output (`--output json`) includes an `alternatives` array for programmatic selection.

## Market Sell

Sell shares you hold:

```bash
bullpen polymarket sell [OPTIONS] <MARKET_SLUG> <OUTCOME> <SHARES>
```

```bash
# Sell 50 Yes shares
bullpen polymarket sell will-bitcoin-hit-100k Yes 50

# Skip confirmation
bullpen polymarket sell will-bitcoin-hit-100k Yes 50 --yes

# Preview
bullpen polymarket sell will-bitcoin-hit-100k Yes 50 --preview
```

**Notes:**
- Selling requires ERC-1155 token approval. If you get an approval error, run `bullpen polymarket approve` first.
- **Share rounding:** Shares are automatically rounded to 2 decimal places before submission. If you sell your exact position (e.g., 28.924238 shares from `positions` output), the CLI rounds to 28.92 shares.
- **Output labels:** Sell output shows "Sold X shares / Received $Y" with correct side-aware labels and average price.

## Limit Buy

Place a limit buy order at a specific price:

```bash
bullpen polymarket limit-buy [OPTIONS] --price <PRICE> --shares <SHARES> <MARKET_SLUG> <OUTCOME>
```

```bash
# Buy 100 shares at $0.45 each
bullpen polymarket limit-buy --price 0.45 --shares 100 will-bitcoin-hit-100k Yes

# Fill-or-Kill (must fill entirely or cancel)
bullpen polymarket limit-buy --price 0.45 --shares 100 --expiration fok will-bitcoin-hit-100k Yes

# Post-only (reject if it would fill immediately)
bullpen polymarket limit-buy --price 0.45 --shares 100 --post-only will-bitcoin-hit-100k Yes

# Skip confirmation
bullpen polymarket limit-buy --price 0.45 --shares 100 --yes will-bitcoin-hit-100k Yes
```

**Price**: 0.01-0.99 (represents cents per share / probability).

**Expiration types:**
- `gtc` (default) — Good-Til-Cancelled: rests on book until cancelled
- `fok` — Fill-Or-Kill: must fill entirely immediately
- `fak` — Fill-And-Kill: fills what it can immediately, cancels rest
- `gtd` — Good-Til-Date: rests until specified date

## Limit Sell

Place a limit sell order:

```bash
bullpen polymarket limit-sell [OPTIONS] --price <PRICE> --shares <SHARES> <MARKET_SLUG> <OUTCOME>
```

```bash
bullpen polymarket limit-sell --price 0.65 --shares 50 will-bitcoin-hit-100k Yes --yes
```

Same options as limit-buy.

Note: Polymarket has a minimum order size of 5 shares for limit orders.
Market orders have a minimum of $1 USDC.

## Redeem Resolved Positions

Redeem winnings from resolved markets:

```bash
bullpen polymarket redeem [OPTIONS]
```

```bash
# Redeem all redeemable positions
bullpen polymarket redeem --yes

# Redeem specific condition IDs
bullpen polymarket redeem --condition-ids 0xabc123,0xdef456 --yes

# Check what's redeemable first
bullpen polymarket positions --redeemable
```

## Pre-Trade Checks

Run safety checks before trading:

```bash
bullpen polymarket preflight
```

Checks: server connectivity, account status, USDC balance, token approvals.

## Token Approvals

Check and set approvals needed for selling:

```bash
bullpen polymarket approve
```

```bash
# Check current approval status
bullpen polymarket approve

# Approvals are gasless (relayer pays gas)
```

Required before your first sell on Polymarket. The approve command handles ERC-1155 approvals for the Exchange, NegRiskExchange, and NegRiskAdapter operators.

## CTF Operations (Split/Merge)

Convert between USDC and outcome tokens directly:

```bash
# Split: USDC -> YES + NO tokens
bullpen polymarket split --condition <CONDITION_ID> --amount <AMOUNT>

# Merge: YES + NO tokens -> USDC
bullpen polymarket merge --condition <CONDITION_ID> --amount <AMOUNT>
```

```bash
# Split $100 into 100 Yes + 100 No shares (use condition ID from market details)
bullpen polymarket split --condition 0xbd31dc8a... --amount 100 --yes

# Merge 50 Yes + 50 No back into $50
bullpen polymarket merge --condition 0xbd31dc8a... --amount 50 --yes
```

To find the condition ID for a market, use `bullpen polymarket market <SLUG> --output json` and look for the `condition_id` field.

Gasless operations. Useful for market-making or arbitrage strategies.

## Depositing Funds

Direct users to the Bullpen web app for all deposits:

```bash
bullpen deposit
```

This opens the web app where deposits are handled safely with asset validation and chain routing.

**IMPORTANT:** Do NOT instruct users to send funds directly to wallet addresses shown in the CLI. The web app handles deposit routing to ensure the correct assets reach the correct chain. Sending wrong assets to raw addresses can result in lost funds.

If the user asks about their wallet addresses for informational purposes only, use `bullpen portfolio balances`.

### Withdraw

Withdraw funds to an external address:

```bash
bullpen polymarket withdraw <ADDRESS> <AMOUNT>
```

### Bridge Status

Check the status of a deposit transaction:

```bash
bullpen polymarket bridge --status <DEPOSIT_ADDRESS>
```

## Real-Time Market Watch

Subscribe to real-time market data via WebSocket:

```bash
bullpen polymarket watch <SLUG>
```

Streams live price updates, orderbook changes, and trades.

## Trade Preview

All trading commands support `--preview` to see what would happen without executing:

```bash
bullpen polymarket buy will-bitcoin-hit-100k Yes 10 --preview
```

Preview shows: side, outcome, market, estimated price, amount, estimated shares, potential payout, current spread.

## Order Status

After placing an order, the CLI shows a status-aware result with side-aware labels:

- **MATCHED** — "Order filled" with spent/received amounts and avg price. For buys: "Spent $X / Received Y shares". For sells: "Sold X shares / Received $Y".
- **LIVE** — "Order resting on book" (limit orders waiting for fills), with a tip to check `bullpen polymarket orders`
- **DELAYED** — "Order delayed" (temporary processing delay)
- **UNMATCHED** — "Order not matched" (no counterparty found)

**Holdings warning:** If you sell immediately after buying, you may see "Positions API shows 0 shares" — this is an indexing delay, not a real error. The order may still succeed if shares are held on-chain. Wait a few seconds and retry if needed.

JSON output (`--output json`) includes full details: `status`, `making_amount`, `taking_amount`, `avg_price`, `transaction_hashes`, and `trade_ids`.

## Exit Codes

- `0` — Success
- `1` — General error (including partial cancel failures)
- `3` — Trade execution failed

## Trading Workflow Recipe

Complete flow from research to executed trade:

```bash
# 1. Find a market
bullpen polymarket search "bitcoin" --output json

# 2. Check current price
bullpen polymarket price will-bitcoin-hit-100k

# 3. Run pre-trade checks
bullpen polymarket preflight

# 4. Preview the order
bullpen polymarket buy will-bitcoin-hit-100k Yes 25 --preview

# 5. Execute
bullpen polymarket buy will-bitcoin-hit-100k Yes 25 --yes

# 6. Verify position
bullpen polymarket positions
```

## Copy Trading

```bash
# Start copying a trader with recommended settings
bullpen tracker copy start <ADDRESS> --preset recommended

# Start with custom settings
bullpen tracker copy start <ADDRESS> --amount 50 --execution-mode auto --exit-behavior mirror-sells

# List active copy trades
bullpen tracker copy list

# View status and recent executions
bullpen tracker copy status <ADDRESS>

# Pause/resume/stop
bullpen tracker copy pause <ADDRESS>
bullpen tracker copy resume <ADDRESS>
bullpen tracker copy stop <ADDRESS> --confirm

# View pending confirmations and confirm/reject
bullpen tracker copy pending
bullpen tracker copy confirm <EXECUTION_ID>
bullpen tracker copy reject <EXECUTION_ID>

# Live monitoring with keyboard confirm/reject
bullpen tracker copy watch

# Risk configuration
bullpen tracker copy risk
bullpen tracker copy risk set --max-per-trade 500 --daily-limit 5000
bullpen tracker copy risk reset

# Stats
bullpen tracker copy stats
```

## Orderbook

```bash
# View bid/ask depth for a market
bullpen polymarket orderbook <SLUG>
bullpen polymarket orderbook <SLUG> --outcome Yes --depth 20
```

## Fee and Fill Preview

Preview fees, slippage, and estimated fill price for a trade before executing:

```bash
# Preview fees, slippage, and fill price before trading
bullpen polymarket preview <SLUG> <OUTCOME> <AMOUNT>
bullpen polymarket preview presidential-election-2028 Yes 100
bullpen polymarket preview fed-rate-cut-june No 50 --side sell
```

## Cross-References

- **Find markets first**: See `references/discovery-and-research.md`
- **Manage positions after trading**: See `references/portfolio-and-orders.md`
- **Automate trades with scripts**: See `references/scripting-and-automation.md`
- **Account setup**: See `references/getting-started.md`
