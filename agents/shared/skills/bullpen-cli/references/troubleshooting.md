# Troubleshooting

Common issues and resolutions for Bullpen CLI users. Use this reference when the user reports a problem that does not require a code change — deposit delays, wrong asset sent, account access, CLI errors.

## 1. Deposit Not Showing

The most common support issue. Deposits go through a bridge and may take 5-15 minutes to appear.

**What to check first:**

```bash
# Open the web app — always use this for deposits
bullpen deposit

# Check your current CLOB balance
bullpen polymarket clob balance

# Check full portfolio including routing wallet
bullpen portfolio balances
```

**Routing wallet vs CLOB balance distinction:**

Bullpen uses two layers of balance:
- **Routing wallet** (GnosisSafe proxy on Polygon) — where bridged funds arrive first
- **CLOB trading balance** — funds available for placing orders on Polymarket

Funds arrive in the routing wallet first. They must be synced or transferred to the CLOB before trading.

**If funds are in routing wallet but not in CLOB balance:**

Run the sync command to pull on-chain balance into the CLOB:

```bash
bullpen polymarket clob balance --update
```

If still not visible after sync, use the web app Transfer feature at `app.bullpen.fi` to move funds from your routing wallet into the CLOB.

**If the deposit was made via fun.xyz (web app):**

Check the fun.xyz status page — delays there are outside Bullpen's control.

**If funds are still missing after 30 minutes:**

File a support ticket with your deposit transaction hash:
```bash
open "https://bullpen-help.freshdesk.com/support/tickets/new"
```

**Prevention:** Always use `bullpen deposit` which opens the web app with proper asset validation and routing. Never send funds directly to a raw address.

## 2. Wrong Asset, Chain, or Address

**ETH sent to proxy wallet (instead of USDC on Polygon):**

Funds are on Ethereum L1 at the user's proxy address. The user controls the private key for this address. Recovery steps:
1. Open the web app at `app.bullpen.fi`
2. Go to Manage Wallets → select the affected wallet → Export Private Key
3. Import the private key into MetaMask or Rabby
4. Send the ETH back to the intended source address

**Wrong token sent to routing wallet:**

Same recovery path — export the proxy wallet private key via the web app, import into MetaMask/Rabby, then transfer the tokens out.

**USDC.e vs native USDC:**

Polymarket uses USDC.e (bridged USDC) on Polygon. Native USDC is a different token. If native USDC was sent, it may need to be swapped to USDC.e via a DEX (e.g., Uniswap on Polygon) before it can be used for trading.

**Prevention:** Always use `bullpen deposit` which opens the web app with proper asset validation. The web app enforces correct token and chain selection.

## 3. Transfer Between Wallets

Bullpen manages several wallet types:
- **Solana wallet** — for Solana-based activity
- **EVM wallet** (Polygon / Arbitrum / Hyperliquid) — for EVM chains
- **Polymarket proxy** (GnosisSafe on Polygon) — the CLOB trading wallet

**How to transfer between wallets:**

Use the web app Transfer button in the top navigation bar at `app.bullpen.fi`. The web app handles routing and bridge selection automatically.

**Solana to Polymarket:**

The web app does not bridge Solana USDC directly to Polygon. Swap to USDC on Solana first, then use the web app bridge to Polygon.

The CLI does not have a transfer command yet. Direct the user to the web app for all cross-wallet transfers.

## 4. Duplicate Proxy Wallets

If `bullpen polymarket doctor` (or `bullpen doctor auth`) shows "Multiple proxy wallets detected":

This is a known backend issue (ENG-4917, now fixed for new users). Existing affected users should contact support with their username:
```bash
open "https://bullpen-help.freshdesk.com/support/tickets/new"
```

Running `bullpen login` again may resolve the issue by re-selecting the correct proxy wallet. If it does not, support can manually clean up the duplicate.

## 5. Cannot Sell or Close a Position

**Sell shows wrong share count:**

Refresh the position data first, then retry the sell:

```bash
bullpen polymarket positions
bullpen polymarket sell <SLUG> <OUTCOME> <SHARES>
```

**"Market unavailable" error:**

The market may be in the resolution period. Wait for settlement and then use `bullpen polymarket redeem` to claim winnings.

**CLI sell hangs or times out:**

Upgrade to the latest version — a 45-second auth timeout fix was shipped in v0.1.48:

```bash
bullpen upgrade
```

**"Approval needed" error:**

Run the approval command before the first sell on a market:

```bash
bullpen polymarket approve
```

**For web app sell issues:**

Try clearing browser cache or use a different browser. The CLOB may also have a brief indexing delay after a recent trade.

## 6. Account Access Recovery

**If the user cannot log in:**

1. Identify which login method was used (Google, X/Twitter, email, or wallet)
2. Try all linked methods on the login page at `app.bullpen.fi`
3. If no method works, contact support with username and email:

```bash
open "https://bullpen-help.freshdesk.com/support/tickets/new"
```

**Prevention:** Link multiple login methods (e.g., Google + email) via the web app account settings page. This provides a backup if one method becomes unavailable.

## 7. USDC Stuck in Proxy Wallet (Not in CLOB Balance)

This happens when USDC lands in the GnosisSafe proxy but is not synced to the CLOB trading balance.

**Step 1:** Run the balance sync command:

```bash
bullpen polymarket clob balance --update
```

**Step 2:** If still stuck, the CLOB balance indexer may be delayed. Wait 10 minutes and retry:

```bash
bullpen polymarket clob balance --update
```

**Step 3:** If still unresolved after 20 minutes, export the proxy wallet private key via the web app (Manage Wallets → Export Private Key) and manually move funds using MetaMask.

## 8. Common CLI Errors

| Error message | Resolution |
|---|---|
| `"Authenticating with Polymarket..."` hangs | Upgrade to v0.1.48+: `bullpen upgrade` (45-second timeout added) |
| `"no Turnkey credential bundle stored"` | Run `bullpen login` to re-authenticate |
| `"market not found"` on redeem | Upgrade to v0.1.51+: `bullpen upgrade` — redeem no longer goes through the signing server and works on all resolved markets. If still failing, use `--condition-ids` with the exact condition ID from `bullpen polymarket positions --output json` |
| `"CLOB auth failed: 401 Unauthorized"` | Run `bullpen login` to refresh credentials |
| `"Multiple proxy wallets detected"` | Contact support — backend fix deployed for new users |
| `"onboarding_complete: false"` | Run `bullpen login` to re-trigger onboarding flow |
| `"Not authenticated"` | Run `bullpen login` |
| `"Insufficient balance"` | Check `bullpen portfolio balances` and fund via `bullpen deposit` |
| `"Order failed"` | Run `bullpen polymarket preflight` to check approvals and balance |

**Auth diagnostics command:**

For any auth-related error, run the dedicated diagnostic command first:

```bash
bullpen doctor auth
```

This shows token validity, onboarding status, wallet readiness, recovery methods, and credential file health without making any changes.

## Cross-References

- **General diagnostics and support ticket filing**: See `references/diagnostics.md`
- **Deposit and balance commands**: See `references/trading.md`
- **Account and auth configuration**: See `references/platform-and-account.md`
- **Community support channels**: See `references/community.md`
