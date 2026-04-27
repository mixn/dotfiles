# Diagnostics

Collect detailed system and account information for troubleshooting. Use this when the user needs help diagnosing an issue or filing a support ticket.

## Quick Auth Diagnostics

Dedicated auth diagnostic command (v0.1.44):

```bash
bullpen doctor auth
bullpen doctor auth --output json
```

Shows: token validity/expiry, onboarding status, wallet readiness, recovery methods, credential file health, CLOB cache status.

## Quick Diagnostic Summary

Run these commands and collect the output:

```bash
# CLI version and build info
bullpen --version

# Full status (version, environment, auth, wallet, skills)
bullpen status

# Configuration
bullpen config show

# Installed skills
bullpen skill list
```

## Step-by-Step Diagnostic Collection

### 1. CLI Version and Environment

```bash
bullpen --version
bullpen status --output json
```

Capture:
- CLI version (e.g., `0.1.40 (Alpha)`)
- Environment (`staging` or `production`)
- Credential store type (`keyring`, `file`, or `ephemeral`)
- Update availability

### 2. System Information

Collect OS and architecture:

```bash
uname -s -r -m          # OS, kernel version, architecture
```

Detect how the CLI was installed:

```bash
which bullpen            # installation path
brew list bullpen 2>/dev/null && echo "Installed via Homebrew"
npm list -g @bullpenfi/cli 2>/dev/null && echo "Installed via npm"
```

### 3. Authentication Status

```bash
bullpen status --output json | jq '.account'
```

Check:
- Whether the user is logged in
- Username
- JWT expiry countdown and refresh token validity (shown in `bullpen status` output since v0.1.52)
- Credential store type and whether tokens are decryptable

### 4. Wallet Information

```bash
# Polymarket proxy address and balances
bullpen polymarket clob balance --output json

# Multi-chain portfolio balances
bullpen portfolio balances --output json

# Operator approvals (required for selling)
bullpen polymarket approve --check --output json
```

Capture:
- Polygon proxy address
- USDC balance
- Conditional token balances
- Approval status for Exchange, NegRiskExchange, NegRiskAdapter operators

### 5. Configuration

```bash
bullpen config show --output json
```

Check:
- `env` (staging vs production)
- `credential_store`
- `trade_server_url` (if overridden)
- `polygon_rpc_url` (if overridden)
- `experimental` features enabled
- `read_only` mode

### 6. Skills

```bash
bullpen skill list --output json
```

Check:
- Installed skills and versions
- Whether any skills are outdated

### 7. What the User Was Trying to Do

Always ask and record:
- What command they ran (exact command line)
- What they expected to happen
- What actually happened (full error output)
- Whether it worked before (regression vs first attempt)
- Any recent changes (upgraded CLI, changed config, etc.)

### 8. Network and Connectivity (if relevant)

```bash
# Test usergate connectivity
bullpen status --output json | jq '.version'

# Test Polymarket CLOB connectivity
bullpen polymarket clob balance --output json 2>&1 | head -5
```

If network issues are suspected, check:
- VPN status
- Geographic restrictions (Polymarket has geoblock on some direct CLOB operations)
- Proxy/firewall settings

## Composing a Support Ticket

Once diagnostics are collected, compose a support message with:

```
**CLI Version:** <version>
**OS:** <os> <arch>
**Install Method:** <homebrew/npm/curl/cargo>
**Environment:** <staging/production>
**Auth Status:** <logged in/out>
**Wallet Address:** <address>
**USDC Balance:** <balance>

**What I was trying to do:**
<description>

**Command run:**
    <exact command>

**Expected behavior:**
<what should have happened>

**Actual behavior:**
<what happened, including full error output>

**Steps to reproduce:**
1. ...
2. ...
```

Then either:
- File a ticket: `open "https://bullpen-help.freshdesk.com/support/tickets/new"`
- Post in Discord: `open "https://discord.com/invite/bullpen"`
- Open a GitHub issue: `open "https://github.com/BullpenFi/bullpen-cli-releases/issues/new"`

## Cross-References

- **Community and support channels**: See `references/community.md`
- **Account and auth troubleshooting**: See `references/platform-and-account.md`
- **Configuration reference**: See `references/platform-and-account.md`
