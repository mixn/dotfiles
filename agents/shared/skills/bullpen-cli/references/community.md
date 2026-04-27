# Community and Support

Connect with the Bullpen community and get help when you need it.

## Community Links

| Channel | URL |
|---------|-----|
| Discord | https://discord.com/invite/bullpen |
| X (Twitter) | https://x.com/BullpenFi |
| Docs | https://cli.bullpen.fi |

## Join Discord

Open the Bullpen Discord server for the user:

```bash
open "https://discord.com/invite/bullpen"        # macOS
xdg-open "https://discord.com/invite/bullpen"    # Linux
```

Discord is the best place to:
- Chat with other CLI users
- Get help with trading strategies
- Report issues and request features
- Share feedback on new features
- Stay up to date on releases

## Follow on X

Open Bullpen's X (Twitter) profile:

```bash
open "https://x.com/BullpenFi"        # macOS
xdg-open "https://x.com/BullpenFi"    # Linux
```

Follow @BullpenFi for:
- New feature announcements
- Market insights
- Community highlights

## File a Support Ticket

Open the Bullpen support portal to file a new ticket:

```bash
open "https://bullpen-help.freshdesk.com/support/tickets/new"        # macOS
xdg-open "https://bullpen-help.freshdesk.com/support/tickets/new"    # Linux
```

When filing a ticket, include:
1. Your CLI version (`bullpen --version`)
2. What you were trying to do
3. The full error message (if any)
4. Steps to reproduce

For faster diagnosis, collect diagnostic info first — see `references/diagnostics.md`.

## Report a Bug

Open a GitHub issue:

```bash
open "https://github.com/BullpenFi/bullpen-cli-releases/issues/new"
```

## Frequently Asked Questions

### Where did my deposit go?

Deposits go through a bridge and may take 5-15 minutes to appear. Check status with:
```bash
bullpen polymarket bridge --status <YOUR_DEPOSIT_ADDRESS>
```
If funds are in your routing wallet but not your trading balance, use the web app's Transfer feature to move them. For the safest deposit experience, always use `bullpen deposit` which opens the web app.

### I sent the wrong token/chain — how do I get it back?

Your funds are in a wallet you control. To recover:
1. Go to the Bullpen web app -> Manage Wallets
2. Export the private key for the wallet that received the funds
3. Import the key into MetaMask or Rabby
4. Send the tokens back to your exchange

To prevent this, always deposit via the web app (`bullpen deposit`) which validates assets and chains automatically.

### How do I transfer between my wallets?

Use the Transfer button in the Bullpen web app's top navigation bar. The web app handles cross-chain bridging automatically (Solana <-> Polygon <-> Hyperliquid).

The CLI does not have a transfer command yet.

### My CLOB balance shows $0 but I have funds on-chain

Run `bullpen polymarket clob balance --update` to sync your on-chain balance with the CLOB. This can take a few minutes after a deposit.

### "market not found" when trying to redeem

The market slug may have changed after resolution. Use the condition ID directly:
```bash
bullpen polymarket redeem --condition-ids <CONDITION_ID> --yes
```
Find your condition IDs with `bullpen polymarket positions --output json`.

### "no Turnkey credential bundle stored"

Run `bullpen login` again. This re-generates your trading credentials. If the issue persists, try `bullpen logout` first, then `bullpen login`.

### "Authenticating with Polymarket..." hangs

Upgrade to the latest version: `bullpen upgrade`. Version 0.1.48+ includes a timeout fix for this issue. If it still hangs after upgrading, check your network connection.

### "Multiple proxy wallets detected"

This is a known backend issue that has been fixed for new accounts. For existing affected accounts, contact support at https://bullpen-help.freshdesk.com/support/tickets/new with your username.

### I can't log back into my account

Try all login methods on the Bullpen web app (Google, X, email, wallet). If none work, contact support with your username and the email you used to sign up.

### How do leaderboard time periods work?

Weekly leaderboard data resets every Monday at 00:00 UTC. Volume and PnL numbers reflect only the current period. Historical data is available via the API with different time period parameters.

### I was asked to verify my identity when depositing

Identity verification during deposits is handled by our payment provider (fun.xyz), not by Bullpen directly. If your ID was rejected or you can't resubmit, contact support at https://bullpen-help.freshdesk.com/support/tickets/new. Alternatively, deposit crypto directly via the web app (`bullpen deposit`) which does not require identity verification.

## Cross-References

- **Diagnostics for support tickets**: See `references/diagnostics.md`
- **Account and auth issues**: See `references/platform-and-account.md`
- **Getting started**: See `references/getting-started.md`
