# Getting Started

Install, authenticate, and configure the Bullpen CLI for prediction market trading on Polymarket.

## Quick Start (4 steps)

```bash
# 1. Install the CLI
brew install bullpenfi/tap/bullpen

# 2. Install AI skills (enables Claude/Codex to trade for you)
bullpen skill install

# 3. Log in
bullpen login

# 4. Restart Claude Code / Codex CLI, then ask it anything:
#    "Buy $10 of Yes on will-bitcoin-hit-100k"
#    "Show me trending prediction markets"
#    "Fill my March Madness bracket with chalk picks"
```

After installing skills and restarting your AI coding assistant, it can discover markets, place trades, manage positions, fill brackets, and automate workflows — all through natural language.

**Already have Bullpen installed?** Run `bullpen upgrade` to update to the latest version (updates the binary and skills automatically).

## Installation

Four installation methods (pick one):

```bash
# Homebrew (macOS/Linux)
brew install bullpenfi/tap/bullpen

# npm (requires Node.js)
npm install -g @bullpenfi/cli

# Shell script
curl -fsSL https://cli.bullpen.fi/install.sh | bash

# Manual download
# Visit https://github.com/BullpenFi/bullpen-cli-releases/releases/latest
```

**System requirements**: macOS 12+, Ubuntu 20.04+, or Windows 11 WSL2.

After install, verify:
```bash
bullpen --version
```

## Install AI Skills

Skills teach Claude Code and Codex CLI how to use Bullpen. Without them, your AI assistant won't know the commands.

```bash
bullpen skill install
```

After installing, **restart your AI assistant** (Claude Code or Codex CLI) so it picks up the new skills. You only need to do this once — skills auto-update when you upgrade the CLI.

## Authentication

Authentication is required for trading, viewing positions, and managing alerts. Read-only operations (discover, search, price) work without auth.

### Login (Device Auth)

```bash
bullpen login
```

Opens your browser with an 8-character code and a QR code. Complete login in the browser and the CLI automatically picks up your session. No copy-pasting required.

**Headless / CI environments:** If no browser is available, use `--no-browser` to print the login URL instead of opening it:

```bash
bullpen login --no-browser
```

### Check Status

```bash
bullpen status
# Shows: CLI version, environment, auth status, wallet address, Polymarket status
```

### Log Out

```bash
bullpen logout
```

## Configuration

Config is stored at `~/.bullpen/config.toml`. Credentials at `~/.bullpen/credentials.json`.

### Initialize Config

```bash
bullpen config init
# Creates config with default settings (production environment)
```

### View Current Config

```bash
bullpen config show
```

### Environment Selection

```bash
# Use staging environment
bullpen --env staging polymarket discover

# Or set in config
bullpen config init --env staging
```

All commands accept `--env staging|production` and `--config <path>` overrides.

## First-Time Setup Wizard

For a guided walkthrough that covers all of the above:

```bash
bullpen setup
```

This runs through authentication, configuration, and initial wallet setup.

## Updating

```bash
bullpen upgrade
# Checks for new version and installs it
```

## Quick Verification

After setup, verify everything works:

```bash
bullpen status              # CLI version, environment, auth status
bullpen portfolio balances  # Your balances across chains
bullpen polymarket discover # Browse prediction markets
```

## Credential Storage

Credentials are stored with this fallback chain:
1. System keyring (most secure)
2. File at `~/.bullpen/credentials.json` (0600 permissions)
3. In-memory (ephemeral, for CI)

## Uninstall

```bash
# 1. Remove AI skills
bullpen skill uninstall --yes

# 2. Remove the binary
brew uninstall bullpen          # Homebrew
# npm uninstall -g @bullpenfi/cli  # npm
# rm "$(which bullpen)"            # shell script install

# 3. Clean up local data (optional — removes credentials and config)
rm -rf ~/.bullpen
```

## What's Next

- **Find markets**: See `references/discovery-and-research.md`
- **Start trading**: See `references/trading.md`
- **Manage positions**: See `references/portfolio-and-orders.md`
- **Fill brackets**: See `references/bracket-contest.md`
