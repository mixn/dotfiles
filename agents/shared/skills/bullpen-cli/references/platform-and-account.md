# Platform and Account

Manage authentication, configuration, multi-chain portfolio, points, and CLI status.

## Authentication

### Login

```bash
bullpen login
```

Uses RFC 8628 device auth: opens your browser with an 8-character code. Complete login in the browser and the CLI automatically picks up your session.

**Headless / CI environments:** Use `--no-browser` to print the login URL instead of opening a browser:

```bash
bullpen login --no-browser
```

### Check Status

```bash
bullpen status
bullpen status --output json
```

Shows: CLI version, environment, auth state, wallet address, Polymarket platform status, JWT expiry countdown, and refresh token validity.

### Logout

```bash
bullpen logout              # Standard logout (server + local)
bullpen logout --force      # Skip server revocation, clear local only
```

### Auth Diagnostics

```bash
# Check authentication and account health
bullpen doctor auth
bullpen doctor auth --output json
```

Shows: token validity/expiry, onboarding status, wallet readiness, recovery methods, credential file health, CLOB cache status.

## Configuration

### Initialize

```bash
bullpen config init [OPTIONS]
```

Creates `~/.bullpen/config.toml` with defaults.

### View

```bash
bullpen config show
bullpen config show --output json
```

### Environment

All commands accept `--env staging|production`:

```bash
bullpen --env staging polymarket discover
```

### Config File Location

- Config: `~/.bullpen/config.toml`
- Credentials: `~/.bullpen/credentials.json`
- Keys: `~/.bullpen/keys/turnkey_p256.json`
- Watchlist: `~/.bullpen/watchlist.json`

## Wallet Management

### List Wallets

```bash
bullpen wallet list
bullpen wallet list --type turnkey
bullpen wallet list --role trading
bullpen wallet list --output json
```

Shows all wallets with their accounts, chain selection status, and roles. Filter by `--type` (turnkey, external, internal) or `--role` (trading, routing). GnosisSafe proxy addresses are annotated with `(proxy)` in the output.

### Select Primary Wallet

```bash
bullpen wallet select <ADDRESS> --chain evm
bullpen wallet select <ADDRESS> --chain solana
```

Sets the primary wallet for all EVM chains (Polygon, Arbitrum, HyperCore) or Solana. The selected wallet will be used for all subsequent trading, portfolio, and balance commands.

After switching, cached credentials are cleared and re-resolved on the next command.

### View Current Selection

```bash
bullpen wallet info
bullpen wallet info --output json
```

Shows which wallet is currently primary for each chain namespace (EVM, Solana), plus the Polymarket Safe address.

## Portfolio (Multi-Chain)

View balances and P&L across all connected chains.

### Overview

```bash
bullpen portfolio overview
bullpen portfolio overview --output json
```

Portfolio value summary across Solana, Hyperliquid, and Polymarket.

### Balances

```bash
bullpen portfolio balances
bullpen portfolio balances --output json
```

Token balances broken down by chain (Solana, Hyperliquid Spot, Hyperliquid Perps, Polymarket).

### P&L

```bash
bullpen portfolio pnl
bullpen portfolio pnl --output json
```

Realized and unrealized profit/loss.

## Points

View your Bullpen points balance:

```bash
bullpen points
bullpen points --output json
```

## Rewards

View and claim Bullpen rewards:

```bash
bullpen rewards
bullpen rewards --output json

# Claim rewards (skip confirmation prompt)
bullpen rewards --claim --yes
```

## CLI Status

Check CLI version, environment, and connection status:

```bash
bullpen status
bullpen status --output json
```

Shows: CLI version, environment (staging/production), authentication status, connected services, JWT expiry countdown, and refresh token validity.

## Upgrade

Update to the latest CLI version:

```bash
bullpen upgrade
```

## Shell Mode

Launch an interactive REPL for running multiple commands:

```bash
bullpen shell
```

## Shell Completion

Generate shell completion scripts:

```bash
# Bash
bullpen completion bash

# Zsh
bullpen completion zsh

# Fish
bullpen completion fish
```

## Setup Wizard

Run the guided first-time setup:

```bash
bullpen setup
```

Walks through: authentication, configuration, wallet initialization.

## Experimental Features

```bash
# List available experimental features
bullpen experimental list

# Enable a feature
bullpen experimental enable <FEATURE>

# Disable a feature
bullpen experimental disable <FEATURE>
```

## Cross-References

- **Get started from scratch**: See `references/getting-started.md`
- **Polymarket-specific positions**: See `references/portfolio-and-orders.md`
- **Start trading**: See `references/trading.md`
- **Community and support**: See `references/community.md`
- **Diagnostics and troubleshooting**: See `references/diagnostics.md`
