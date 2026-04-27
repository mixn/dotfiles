---
name: bullpen-cli
description: "Use the Bullpen CLI to trade Polymarket prediction markets, discover events, manage portfolios, and automate trading workflows. Use when the user asks about prediction markets, Polymarket, buying/selling shares, checking positions, market discovery, orderbooks, tracking traders, or scripting prediction market operations. Do NOT use for building Polymarket API integrations from scratch or for non-Polymarket protocols."
license: MIT
metadata:
  author: BullpenFi
  version: "0.1.64"
  tags: [prediction-markets, polymarket, trading, cli, portfolio]
  docs-url: cli.bullpen.fi
---

# Bullpen CLI Skill

> This is a live example of the AI agent skill format. For the full format specification, see [AI Agent Skill Format Specification](https://cli.bullpen.fi/skill-format-spec/).

## Instructions

### Quick Start (if user is new)

If the user hasn't set up Bullpen yet, guide them through these 4 steps:

1. **Install CLI**: `brew install bullpenfi/tap/bullpen`
2. **Install AI skills**: `bullpen skill install`
3. **Log in**: `bullpen login`
4. **Restart Claude/Codex** so it picks up the new skills, then ask it anything

To update an existing install: `bullpen upgrade` (updates the binary and skills automatically).

### Step 1: Identify What the User Wants to Do

Route to the right reference based on the user's intent:

**Getting started** (install, authenticate, configure, install skills):
- `references/getting-started.md`

**Find and research markets** (discover, search, events, prices, tags, series):
- `references/discovery-and-research.md`

**Trade** (buy, sell, limit orders, redeem, CTF split/merge, bridge funds):
- `references/trading.md`

**Manage portfolio and orders** (positions, open orders, cancel, watchlist, activity):
- `references/portfolio-and-orders.md`

**Social and signals** (comments, feeds, alerts, tracker, leaderboard):
- `references/social-and-signals.md`

**Account and platform** (auth, config, portfolio balances, points, status):
- `references/platform-and-account.md`

**Wallet management** (list wallets, select primary, switch chains):
- `references/platform-and-account.md`

**Step-by-step tutorials** (complete workflows with exact commands):
- `references/trading-tutorial.md` — discover → trade → manage → redeem
- `references/copy-trading-tutorial.md` — find traders → copy → monitor → manage
- `references/tracker-tutorial.md` — track wallets → groups → watchlist → alerts

**Scripting and automation** (JSON output, jq piping, batch workflows):
- `references/scripting-and-automation.md`

**Bracket contests** (March Madness, tournament picks, fill bracket, leaderboard):
- `references/bracket-contest.md`

**Community and support** (Discord, X/Twitter, file a ticket, report a bug):
- `references/community.md`

**Diagnostics and troubleshooting** (collect system info, debug errors, file support tickets):
- `references/diagnostics.md`

**Troubleshooting** (deposit not showing, wrong asset, account access, CLI errors):
- `references/troubleshooting.md`

Many tasks span multiple categories. Read all relevant references before acting.

### Step 2: Key Rules

Before running any command, keep these rules in mind:

- **All commands support `--output json`** for machine-readable output. Default is `table`.
- **Trading commands require `--yes`** to skip interactive confirmation (essential for automation).
- **Authentication is required** for any write operation (trading, orders, alerts, comments).
- **Read-only operations** (discover, search, price, event, leaderboard) work without auth.
- **Market slugs** are the primary identifier (e.g., `will-bitcoin-hit-100k`), not numeric IDs.
- **Outcomes** are specified by name: `Yes`, `No`, or the outcome text for multi-outcome markets. Aliases work too: `Y`/`N`, `True`/`False`, `1`/`0`.
- **Prices** are 0.01-0.99 (representing cents per share / probability).
- **Global flags**: `--env staging|production`, `--config <path>` work on all commands.

### Step 3: Execute

Run commands via `bullpen` CLI. If the CLI is not installed, start with `references/getting-started.md`.

## Quick Command Map

Use this for simple queries without reading full references:

| Intent | Command |
|--------|---------|
| Install CLI | `brew install bullpenfi/tap/bullpen` |
| Log in | `bullpen login` |
| Check auth status | `bullpen status` |
| Discover markets | `bullpen polymarket discover` |
| Discover sports markets | `bullpen polymarket discover sports` |
| Discover crypto markets | `bullpen polymarket discover crypto` |
| Search markets | `bullpen polymarket search "bitcoin"` |
| Get event details | `bullpen polymarket event <SLUG>` |
| Check price | `bullpen polymarket price <SLUG>` |
| Check price history | `bullpen polymarket price-history <SLUG> --outcome <OUTCOME>` |
| View market details | `bullpen polymarket market <SLUG>` |
| List markets with filters | `bullpen polymarket markets --active --sort volume` |
| Browse tags | `bullpen polymarket tags` |
| Browse series | `bullpen polymarket series` |
| Buy shares | `bullpen polymarket buy <SLUG> <OUTCOME> <USD_AMOUNT>` |
| Sell shares | `bullpen polymarket sell <SLUG> <OUTCOME> <SHARES>` |
| Limit buy | `bullpen polymarket limit-buy --price 0.45 --shares 100 <SLUG> <OUTCOME>` |
| Limit sell | `bullpen polymarket limit-sell --price 0.65 --shares 50 <SLUG> <OUTCOME>` |
| View positions | `bullpen polymarket positions` |
| View open orders | `bullpen polymarket orders` |
| Cancel an order | `bullpen polymarket orders --cancel <ORDER_ID>` |
| Cancel all orders | `bullpen polymarket orders --cancel-all --yes` |
| Redeem resolved | `bullpen polymarket redeem` |
| View watchlist | `bullpen tracker watchlist` |
| Add to watchlist | `bullpen tracker watchlist add <SLUG>` |
| View activity | `bullpen polymarket activity` |
| View recent trades | `bullpen polymarket trades <SLUG>` |
| View top holders | `bullpen polymarket holders <SLUG>` |
| View comments | `bullpen polymarket comments <SLUG>` |
| View trade feed | `bullpen polymarket feed trades` |
| View comment feed | `bullpen polymarket feed comments` |
| Set smart alerts (legacy) | `bullpen polymarket smart-alerts --set --smart-money true` |
| Leaderboard | `bullpen polymarket data leaderboard` |
| Trader profile | `bullpen polymarket data profile <ADDRESS>` |
| Smart money signals | `bullpen polymarket data smart-money` |
| Portfolio balances | `bullpen portfolio balances` |
| Portfolio P&L | `bullpen portfolio pnl` |
| List wallets | `bullpen wallet list` |
| Set primary EVM wallet | `bullpen wallet select <ADDRESS> --chain evm` |
| Set primary Solana wallet | `bullpen wallet select <ADDRESS> --chain solana` |
| View primary wallets | `bullpen wallet info` |
| Track a trader | `bullpen tracker add <ADDRESS>` |
| Track with group | `bullpen tracker add <ADDRESS> --group <ID> --nickname "Name"` |
| List tracked addresses | `bullpen tracker list` |
| View tracked trades | `bullpen tracker feed` |
| Manage groups | `bullpen tracker groups` |
| Create a group | `bullpen tracker groups create "Name" --emoji "🐋"` |
| Share a group | `bullpen tracker groups share <GROUP_ID>` |
| Import a group | `bullpen tracker groups import <CODE>` |
| Browse curated groups | `bullpen tracker groups curated` |
| View alerts config | `bullpen tracker alerts` |
| Set trade alert | `bullpen tracker alerts trade set --min-trade-size 5000 --tracked-only` |
| Set smart alerts | `bullpen tracker alerts smart --smart-money true` |
| Check CLI status | `bullpen status` |
| Upgrade CLI | `bullpen upgrade` |
| List bracket contests | `bullpen polymarket bracket contests --status open` |
| Auto-fill chalk bracket | `bullpen polymarket bracket fill-chalk <CONTEST_ID> --tiebreaker 145` |
| Fill bracket from file | `bullpen polymarket bracket fill <CONTEST_ID> --file picks.json` |
| Bracket summary | `bullpen polymarket bracket summary <CONTEST_ID>` |
| Submit bracket pick | `bullpen polymarket bracket pick <CONTEST_ID> --slot <SLOT> --winner "Duke"` |
| Bracket leaderboard | `bullpen polymarket bracket leaderboard <CONTEST_ID>` |
| Deposit funds | `bullpen deposit` (opens web app) |
| Join Discord | `open "https://discord.com/invite/bullpen"` |
| Follow on X | `open "https://x.com/BullpenFi"` |
| File support ticket | `open "https://bullpen-help.freshdesk.com/support/tickets/new"` |
| Collect diagnostics | `bullpen status --output json` + `bullpen config show --output json` |
| Copy a trader | `bullpen tracker copy start <ADDRESS> --preset recommended` |
| List copy trades | `bullpen tracker copy list` |
| View copy trade status | `bullpen tracker copy status <ADDRESS>` |
| Pending confirmations | `bullpen tracker copy pending` |
| Confirm copy trade | `bullpen tracker copy confirm <ID>` |
| Watch copy trades live | `bullpen tracker copy watch` |
| Copy trade stats | `bullpen tracker copy stats` |
| Copy trade risk config | `bullpen tracker copy risk` |
| View orderbook | `bullpen polymarket orderbook <SLUG>` |
| Preview trade fees | `bullpen polymarket preview <SLUG> <OUTCOME> <AMOUNT>` |
| Auth diagnostics | `bullpen doctor auth` |
| Force logout | `bullpen logout --force` |

## Examples

### Example 1: First-Time Setup and First Trade

User says: "Set up Bullpen and buy Yes on the Bitcoin market"

Actions:
1. Install: `brew install bullpenfi/tap/bullpen`
2. Log in: `bullpen login`
3. Verify: `bullpen status`
4. Find the market: `bullpen polymarket search "bitcoin"`
5. Check the price: `bullpen polymarket price will-bitcoin-hit-100k`
6. Buy shares: `bullpen polymarket buy will-bitcoin-hit-100k Yes 10 --yes`
7. Verify position: `bullpen polymarket positions`

### Example 2: Market Research Workflow

User says: "Research the most active prediction markets"

Actions:
1. Discover trending: `bullpen polymarket discover --sort volume --limit 10 --output json`
2. Pick an event and drill down: `bullpen polymarket event <SLUG> --output json`
3. Check pricing: `bullpen polymarket price <SLUG> --output json`
4. View recent trades: `bullpen polymarket trades <SLUG> --output json`
5. Check top holders: `bullpen polymarket holders <SLUG> --output json`
6. Check smart money: `bullpen polymarket data smart-money --output json`

### Example 3: Execute a Buy and Verify

User says: "Buy $50 of Yes shares on will-trump-win and show me the position"

Actions:
1. Preview the order: `bullpen polymarket buy will-trump-win Yes 50 --preview`
2. Execute: `bullpen polymarket buy will-trump-win Yes 50 --yes`
3. Check position: `bullpen polymarket positions --output json`

### Example 4: Set Up Smart Money Alerts

User says: "Alert me when whales trade on crypto markets"

Actions:
1. Enable smart alerts: `bullpen polymarket smart-alerts --set --smart-money true --top-traders true --categories crypto`
2. Track specific traders: `bullpen tracker add <ADDRESS>`
3. Check current alerts: `bullpen polymarket smart-alerts --output json`

### Example 5: Automated Portfolio Monitoring

User says: "Script that checks my positions and finds markets to trade"

```bash
# Check positions
bullpen polymarket positions --output json | jq '.positions[] | {market: .title, shares: .size, value: .current_value}'

# Find high-volume active markets
bullpen polymarket discover --sort volume --min-liquidity 100000 --output json | jq '.markets[] | {title, volume, liquidity}'

# Check prices on watchlist
bullpen tracker watchlist --output json | jq -r '.markets[].slug' | while read slug; do
  bullpen polymarket price "$slug" --output json
done

# Get leaderboard for strategy ideas
bullpen polymarket data leaderboard --period week --limit 5 --output json
```

## Troubleshooting

| Error | Fix |
|-------|-----|
| "Not authenticated" | Run `bullpen login` |
| "Market not found" | The CLI will suggest similar markets ("Did you mean?"). Use slugs from `bullpen polymarket search` or `discover`, not numeric IDs. You can also paste a full Polymarket URL. |
| "Insufficient balance" | Check `bullpen portfolio balances` and fund via `bullpen deposit` (opens web app) |
| "Positions API shows 0 shares" | This is an indexing delay warning after a recent trade, not a real error. The order may still succeed. Wait a few seconds and retry, or run `bullpen polymarket positions` to verify holdings. |
| "Rate limited" | Wait 30 seconds and retry; reduce request frequency in scripts |
| "Order failed" | Run `bullpen polymarket preflight` to check approvals and balance |
| "Approval needed" | Run `bullpen polymarket approve` before first sell on a market |
| Command not found | Run `bullpen upgrade` to get the latest version |
| Config issues | Run `bullpen config init` to reset, or `bullpen config show` to inspect |
| Other bugs | Report at [github.com/BullpenFi/bullpen-cli-releases/issues](https://github.com/BullpenFi/bullpen-cli-releases/issues) or [help.bullpen.fi](https://help.bullpen.fi) |

## Resources

- Docs: [cli.bullpen.fi](https://cli.bullpen.fi)
- Bug reports: [github.com/BullpenFi/bullpen-cli-releases/issues](https://github.com/BullpenFi/bullpen-cli-releases/issues)
- Support: [help.bullpen.fi](https://help.bullpen.fi)
- Releases: [github.com/BullpenFi/bullpen-cli-releases](https://github.com/BullpenFi/bullpen-cli-releases)
- Full LLM docs bundle: [cli.bullpen.fi/llm.txt](https://cli.bullpen.fi/llm.txt)
