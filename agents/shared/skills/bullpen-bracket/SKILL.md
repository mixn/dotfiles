---
name: bullpen-bracket
description: "AI-assisted bracket contest filling and management for Polymarket tournament contests (e.g. March Madness). Use when the user wants to fill a bracket, make picks, submit a tiebreaker, view standings, check results, or automate bracket strategies. Provides command reference, slot ID format, scoring rules, and strategy templates (chalk, upset-heavy, custom champion)."
license: MIT
metadata:
  author: BullpenFi
  version: "0.1.64"
  tags: [bracket, march-madness, tournament, polymarket, prediction-markets, sports]
  docs-url: cli.bullpen.fi
---

# Bullpen Bracket Skill

> This is a live example of the AI agent skill format. For the full format specification, see [AI Agent Skill Format Specification](https://cli.bullpen.fi/skill-format-spec/).

## Instructions

### Step 1: Identify What the User Wants to Do

Route to the right section based on intent:

| User Intent | Go To |
|-------------|-------|
| Find bracket contests | [List Contests](#list-contests) |
| See the full tournament bracket | [Display Tournament Bracket](#display-tournament-bracket) |
| Submit picks (one or many) | [Submit a Single Pick](#submit-a-single-pick) |
| Fill entire bracket automatically | [Auto-Fill Bracket](#auto-fill-bracket) |
| Fill from a JSON file | [Fill from File](#fill-from-file) |
| See bracket summary | [View Bracket Summary](#view-bracket-summary) |
| Set tiebreaker score | [Submit Tiebreaker](#submit-tiebreaker) |
| See standings / my rank | [View Leaderboard](#view-leaderboard) / [View Your Status](#view-your-status) |
| Check game outcomes | [View Game Results](#view-game-results) |
| See Polymarket market mappings | [View Polymarket Market Mappings](#view-polymarket-market-mappings) |
| Strategy help | [Strategy Templates](#strategy-templates) |

Read `references/bracket-contest.md` for full command reference, slot ID format, scoring rules, strategy templates, and the automated fill script.

### Step 2: Key Rules

- **Authentication required** for all write operations (picks, tiebreaker). Run `bullpen login` first.
- **Slot IDs** follow the format `R{round}_{region}_{game}`. Get exact slot IDs from `bullpen polymarket bracket bracket-view <id>`.
- **Team names support fuzzy matching** — you can use short names like "Duke", "Illinois", "Michigan St" instead of full university names. The CLI resolves against the server's team list.
- **R2+ picks work** — for later-round matchups where opponents are TBD, the CLI resolves team names against all tournament entries.
- **Round-by-round submission** — `fill-chalk` and `fill` submit picks round by round (R1 first, then R2-R6) with automatic fallback to individual submission if a batch fails.
- **Dry-run mode** — use `--dry-run` on `fill-chalk` or `fill` to preview picks without submitting.
- **Consistency warnings** — picking a team in R2+ that you didn't pick to advance from the previous round triggers a warning (non-blocking).
- **Tiebreaker** is the predicted total points in the championship game. Submit after filling all 63 picks.
- **All commands support `--output json`** for scripting and automation.

### Step 3: Execute

Run commands via `bullpen` CLI. Bracket commands are all under `bullpen polymarket bracket`.

## Quick Command Map

| Intent | Command |
|--------|---------|
| List open contests | `bullpen polymarket bracket contests --status open` |
| View contest details | `bullpen polymarket bracket view <CONTEST_ID>` |
| Display bracket tree | `bullpen polymarket bracket bracket-view <CONTEST_ID>` |
| View my picks | `bullpen polymarket bracket picks <CONTEST_ID>` |
| View picks for one round | `bullpen polymarket bracket picks <CONTEST_ID> --round 1` |
| Submit one pick | `bullpen polymarket bracket pick <CONTEST_ID> --slot <SLOT> --winner "Duke"` |
| Preview chalk bracket | `bullpen polymarket bracket fill-chalk <CONTEST_ID> --dry-run` |
| Auto-fill chalk bracket | `bullpen polymarket bracket fill-chalk <CONTEST_ID> --tiebreaker 145` |
| Fill from JSON file | `bullpen polymarket bracket fill <CONTEST_ID> --file picks.json` |
| View bracket summary | `bullpen polymarket bracket summary <CONTEST_ID>` |
| Submit tiebreaker | `bullpen polymarket bracket submit <CONTEST_ID> --tiebreaker <SCORE>` |
| View leaderboard | `bullpen polymarket bracket leaderboard <CONTEST_ID>` |
| My rank and score | `bullpen polymarket bracket status <CONTEST_ID>` |
| Game results | `bullpen polymarket bracket results <CONTEST_ID>` |
| Polymarket mappings | `bullpen polymarket bracket markets <CONTEST_ID>` |

## Examples

### Example 1: Fill a Full Bracket (Chalk Strategy)

User says: "Fill my March Madness bracket picking the higher seed every time"

Actions:
1. Find the active contest: `bullpen polymarket bracket contests --status open --output json`
2. Auto-fill all 63 picks with chalk (higher seed always wins): `bullpen polymarket bracket fill-chalk <CONTEST_ID> --tiebreaker 145`
3. Review the bracket summary: `bullpen polymarket bracket summary <CONTEST_ID>`
4. Override specific picks if desired: `bullpen polymarket bracket pick <CONTEST_ID> --slot R1_E2 --winner "TCU"`
5. Verify: `bullpen polymarket bracket picks <CONTEST_ID>`

### Example 2: Fill a Bracket with a Specific Champion

User says: "Fill my bracket with Duke winning it all"

Actions:
1. Find contest: `bullpen polymarket bracket contests --status open --output json`
2. Start with chalk base: `bullpen polymarket bracket fill-chalk <CONTEST_ID> --tiebreaker 152`
3. Override Duke's path to the championship — work backwards from R6:
   - `bullpen polymarket bracket pick <CONTEST_ID> --slot R6_CH1 --winner "Duke"`
   - `bullpen polymarket bracket pick <CONTEST_ID> --slot R5_FF1 --winner "Duke"`
   - (continue for Elite 8, Sweet 16, etc.)
4. Review: `bullpen polymarket bracket summary <CONTEST_ID>`
5. Verify all 63 picks: `bullpen polymarket bracket picks <CONTEST_ID>`

### Example 3: Check Standings Mid-Tournament

User says: "How am I doing in the bracket contest?"

Actions:
1. Quick overview: `bullpen polymarket bracket summary <CONTEST_ID>`
2. Check your rank: `bullpen polymarket bracket status <CONTEST_ID>`
3. View recent results: `bullpen polymarket bracket results <CONTEST_ID>`
4. See leaderboard: `bullpen polymarket bracket leaderboard <CONTEST_ID>`
5. Compare max possible points vs current leader to assess your path to winning

### Example 4: Fill from a JSON File

User says: "I have my picks in a file, submit them all"

Actions:
1. Create a picks file (`picks.json`):
   ```json
   {
     "picks": [
       {"slot": "R1_E1", "winner": "Duke"},
       {"slot": "R1_E2", "winner": "TCU"},
       {"slot": "R1_E3", "winner": "Illinois"}
     ],
     "tiebreaker": 148
   }
   ```
2. Submit: `bullpen polymarket bracket fill <CONTEST_ID> --file picks.json`
3. Team names support fuzzy matching — "Duke", "Illinois", "Michigan St" all work.
4. Verify: `bullpen polymarket bracket summary <CONTEST_ID>`

## March Madness Quick Reference

**64 teams, 4 regions** (East, West, South, Midwest), **63 total picks**

| Round | Games | Pts/Pick | Max Pts |
|-------|-------|----------|---------|
| First Round | 32 | 1 | 32 |
| Second Round | 16 | 2 | 32 |
| Sweet 16 | 8 | 4 | 32 |
| Elite 8 | 4 | 8 | 32 |
| Final Four | 2 | 16 | 32 |
| Championship | 1 | 32 | 32 |
| **Total** | **63** | — | **192** |

**Historic upset rates (Round 1):**
- 12 over 5: ~35%
- 11 over 6: ~37%
- 10 over 7: ~40%
- 13 over 4: ~21%
- 14 over 3: ~15%
- 15 over 2: ~6%
- 16 over 1: ~1% (has happened once in history)

## Troubleshooting

| Error | Fix |
|-------|-----|
| "Not authenticated" | Run `bullpen login` |
| "Contest not found" | Run `bullpen polymarket bracket contests` to get valid IDs |
| "Invalid slot ID" | Use `bracket-view --output json` to get exact slot IDs |
| "No team matching..." | Check team names with `bracket-view`. Fuzzy matching works for short names ("Duke", "UNC") |
| "Ambiguous team name..." | Be more specific — the error lists matching candidates |
| "Warning: ... not picked to advance" | Consistency warning — your later-round pick doesn't match an earlier pick. Non-blocking. |
| "Picks deadline passed" | Contest is closed — check `bracket-view` for deadline field |
| Command not found | Run `bullpen upgrade` to get the latest version |

## Full Reference

See `references/bracket-contest.md` for:
- Complete command syntax and all flags
- Full slot ID format specification
- All strategy templates (chalk, upset-heavy, custom champion, contrarian)
- Automated fill script
- Polymarket market mapping usage

## Resources

- Docs: [cli.bullpen.fi](https://cli.bullpen.fi)
- Bug reports: [github.com/BullpenFi/bullpen-cli-releases/issues](https://github.com/BullpenFi/bullpen-cli-releases/issues)
- Support: [help.bullpen.fi](https://help.bullpen.fi)
- Releases: [github.com/BullpenFi/bullpen-cli-releases](https://github.com/BullpenFi/bullpen-cli-releases)
