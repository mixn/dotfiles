# Social and Signals

Monitor market commentary, track traders, view leaderboards, and configure alerts.

## Comments

View comments on markets, events, series, or by user:

```bash
bullpen polymarket comments [OPTIONS] [SLUG]
```

```bash
# Comments on a market
bullpen polymarket comments will-bitcoin-hit-100k

# Comments on an event
bullpen polymarket comments --event some-event-slug

# Comments on a series
bullpen polymarket comments --series some-series-slug

# Comments by a specific user
bullpen polymarket comments --user 0x1234...abcd

# Replies to a comment
bullpen polymarket comments --replies <COMMENT_ID>

# Smart-filtered feed (filters spam/low-quality)
bullpen polymarket comments --filtered

# Filter by commenter quality
bullpen polymarket comments --filtered --min-pnl 1000 --min-volume 10000

# Only from followed users
bullpen polymarket comments --filtered --following-only

# Paginate
bullpen polymarket comments will-bitcoin-hit-100k --page 2 --limit 50

# JSON output
bullpen polymarket comments will-bitcoin-hit-100k --output json
```

## Feeds

View aggregated trade or comment feeds across all markets:

```bash
bullpen polymarket feed <TYPE> [OPTIONS]
```

**Feed types**: `trades`, `comments`

```bash
# Trade feed
bullpen polymarket feed trades

# Comment feed
bullpen polymarket feed comments

# Filter trade feed by quality
bullpen polymarket feed trades --min-trade-size 1000 --min-pnl 5000

# Filter by price range
bullpen polymarket feed trades --min-price 0.10 --max-price 0.90

# Filter by action
bullpen polymarket feed trades --action Buy

# Filter by category
bullpen polymarket feed trades --category crypto

# Exclude categories
bullpen polymarket feed trades --exclude-categories sports,entertainment

# Comment feed from followed users only
bullpen polymarket feed comments --following-only

# Paginate
bullpen polymarket feed trades --page 1 --limit 50

# JSON output
bullpen polymarket feed trades --output json
```

## Alerts

### Comment Alerts

Manage alerts for comments on markets you follow:

```bash
bullpen polymarket comment-alert [OPTIONS]
```

### Trade Alerts

Manage alerts for trades on markets you follow:

```bash
bullpen polymarket trade-alert [OPTIONS]
```

### Smart Alerts

Configure smart alert preferences for automated notifications:

```bash
bullpen polymarket smart-alerts [OPTIONS]
```

```bash
# View current settings
bullpen polymarket smart-alerts

# Enable smart money alerts
bullpen polymarket smart-alerts --set --smart-money true

# Enable top trader alerts
bullpen polymarket smart-alerts --set --top-traders true

# Enable new wallet alerts
bullpen polymarket smart-alerts --set --new-wallet true

# Set preferred categories
bullpen polymarket smart-alerts --set --categories crypto,politics

# Combine settings
bullpen polymarket smart-alerts --set --smart-money true --top-traders true --categories crypto

# JSON output
bullpen polymarket smart-alerts --output json
```

## Tracker

Unified entry point for tracking Polymarket traders, organizing into groups, managing your watchlist, and configuring alerts.

### Track Addresses

```bash
# Track a Polymarket address
bullpen tracker add <ADDRESS>

# Track with nickname and group
bullpen tracker add <ADDRESS> --nickname "GCR" --group <GROUP_ID>

# Track with notifications
bullpen tracker add <ADDRESS> --notify-trades true --trade-threshold 5000

# Stop tracking
bullpen tracker remove <ADDRESS>

# List all tracked addresses
bullpen tracker list

# Filter by group
bullpen tracker list --group <GROUP_ID>

# Update tracking settings (nickname, notifications — no --group flag)
bullpen tracker update <ADDRESS> --notify-trades true --notify-comments true

# View trade feed from tracked addresses
bullpen tracker feed

# Filter feed by group or address
bullpen tracker feed --group <GROUP_ID> --limit 50

# JSON output
bullpen tracker list --output json
```

### Wallet Groups

Organize tracked addresses into named groups with sharing support:

```bash
# List all groups
bullpen tracker groups

# Create a group
bullpen tracker groups create "Whales" --emoji "🐋"

# Edit a group
bullpen tracker groups edit <GROUP_ID> --name "Top Whales" --emoji "🐳"

# Delete a group
bullpen tracker groups delete <GROUP_ID> --confirm

# Toggle notifications for all addresses in a group
bullpen tracker groups notify <GROUP_ID> on

# Share a group (generates a share code)
bullpen tracker groups share <GROUP_ID>

# Import a group from a share code
bullpen tracker groups import <CODE>

# Browse curated groups
bullpen tracker groups curated

# Import a curated group
bullpen tracker groups curated import <GROUP_ID>
```

### Watchlist

Bookmark markets to track prices and activity:

```bash
# List watchlist items
bullpen tracker watchlist

# Add a Polymarket event to watchlist
bullpen tracker watchlist add presidential-election-2028

# Remove from watchlist
bullpen tracker watchlist remove presidential-election-2028

# View details for a watchlist item
bullpen tracker watchlist view presidential-election-2028

# JSON output
bullpen tracker watchlist --output json
```

### Alerts

Configure global trade/comment alerts and smart alert settings:

```bash
# View all alert configuration
bullpen tracker alerts

# View trade alert config
bullpen tracker alerts trade

# Set a trade alert
bullpen tracker alerts trade set --min-trade-size 5000 --action Buy --tracked-only

# Delete trade alert
bullpen tracker alerts trade delete

# Set a comment alert
bullpen tracker alerts comment set --min-pnl 100000 --tracked-only

# Delete comment alert
bullpen tracker alerts comment delete

# View smart alert settings
bullpen tracker alerts smart

# Configure smart alerts
bullpen tracker alerts smart --smart-money true --top-traders true --categories crypto,politics
```

## Leaderboard

View top traders ranked by performance:

```bash
bullpen polymarket data leaderboard [OPTIONS]
```

```bash
# All-time leaderboard
bullpen polymarket data leaderboard

# Weekly leaders
bullpen polymarket data leaderboard --period week

# Daily leaders, top 10
bullpen polymarket data leaderboard --period day --limit 10

# JSON output
bullpen polymarket data leaderboard --output json
```

**Periods**: `day`, `week`, `month`, `all` (default)

## Trader Profiles

Look up detailed stats for any trader:

```bash
bullpen polymarket data profile <ADDRESS>
```

```bash
bullpen polymarket data profile 0x1234...abcd --output json
```

Returns: total volume, P&L, win rate, number of predictions, account age.

## Smart Money Signals

View aggregated smart money activity:

```bash
bullpen polymarket data smart-money [OPTIONS]
```

```bash
bullpen polymarket data smart-money --output json
```

## Notifications

View account notifications:

```bash
bullpen notifications
bullpen notifications --output json
```

## Social Monitoring Workflow

Set up comprehensive market monitoring:

```bash
# 1. Create a group and track top traders from leaderboard
bullpen tracker groups create "Whales" --emoji "🐋"
bullpen polymarket data leaderboard --period week --limit 5 --output json
# Then track interesting addresses into the group:
bullpen tracker add <ADDRESS> --group <GROUP_ID> --notify-trades true

# 2. Add markets to your watchlist
bullpen tracker watchlist add presidential-election-2028
bullpen tracker watchlist add fed-rate-cut-june

# 3. Configure alerts
bullpen tracker alerts trade set --min-trade-size 5000 --tracked-only
bullpen tracker alerts smart --smart-money true --top-traders true

# 4. Monitor trade feed from your tracked group
bullpen tracker feed --group <GROUP_ID>

# 5. Check your watchlist
bullpen tracker watchlist

# 6. Read high-quality comments
bullpen polymarket comments --filtered --min-pnl 5000
```

## Cross-References

- **Research markets mentioned in feeds**: See `references/discovery-and-research.md`
- **Act on signals by trading**: See `references/trading.md`
- **Check your own positions**: See `references/portfolio-and-orders.md`
- **Automate monitoring**: See `references/scripting-and-automation.md`
