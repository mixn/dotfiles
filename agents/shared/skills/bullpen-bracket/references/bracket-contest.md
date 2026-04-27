# Bracket Contest

Fill and manage tournament bracket picks on Polymarket bracket contests. All bracket commands are under `bullpen polymarket bracket`.

## List Contests

Discover available bracket contests:

```bash
bullpen polymarket bracket contests
bullpen polymarket bracket contests --status open
bullpen polymarket bracket contests --output json
```

**Status values:** `upcoming`, `open`, `locked`

## View Contest Details

Get full contest metadata (name, description, deadlines, scoring rules):

```bash
bullpen polymarket bracket view <CONTEST_ID>
bullpen polymarket bracket view <CONTEST_ID> --output json
```

## Display Tournament Bracket

Visualize the full bracket tree — teams, seeds, matchups, and round structure:

```bash
bullpen polymarket bracket bracket-view <CONTEST_ID>
bullpen polymarket bracket bracket-view <CONTEST_ID> --output json
```

The bracket view shows:
- All regions and their seeds (1–16)
- Current matchups per round
- Already-decided games with results
- Your existing picks (if any)

Use this as your starting point before filling picks.

## View Your Picks

See all picks you have submitted so far:

```bash
bullpen polymarket bracket picks <CONTEST_ID>
bullpen polymarket bracket picks <CONTEST_ID> --output json

# Filter by round (1-6)
bullpen polymarket bracket picks <CONTEST_ID> --round 1
bullpen polymarket bracket picks <CONTEST_ID> --round 3   # Sweet 16 only
```

JSON output includes `slot`, `winner`, `is_correct` (null until game resolves), and `points_earned`.

## Submit a Single Pick

Submit or update one pick at a time. Team names support **fuzzy matching** — use short names like "Duke", "Illinois", "Michigan St" instead of full university names.

```bash
bullpen polymarket bracket pick <CONTEST_ID> --slot <SLOT_ID> --winner <TEAM_NAME>
```

```bash
# Pick Duke to win slot R1_E1 (Region East, Round 1, Game 1)
bullpen polymarket bracket pick march-madness-2026 --slot R1_E1 --winner "Duke"

# Fuzzy matching works — all of these resolve correctly:
bullpen polymarket bracket pick <ID> --slot R1_S1 --winner "Illinois"
bullpen polymarket bracket pick <ID> --slot R1_E2 --winner "Michigan St"
bullpen polymarket bracket pick <ID> --slot R1_W3 --winner "UConn"
```

**Consistency check:** When picking for R2+, the CLI warns if the picked team wasn't selected to advance from the previous round. This is a non-blocking warning.

**Slot ID format:** `R{round}_{region}_{game}`
- Round: `R1` through `R6` (R6 = Championship)
- Region: `E` (East), `W` (West), `S` (South), `MW` (Midwest), `FF` (Final Four), `CH` (Championship)
- Game: sequential number within that round and region

Example slots:
| Slot | Meaning |
|------|---------|
| `R1_E1` | East region, Round 1, Game 1 (seed 1 vs seed 16) |
| `R1_E8` | East region, Round 1, Game 8 (seed 8 vs seed 9) |
| `R2_W4` | West region, Round 2, Game 4 |
| `R3_S2` | South region, Sweet 16, Game 2 |
| `R4_MW1` | Midwest region, Elite 8, Game 1 |
| `R5_FF1` | Final Four, Game 1 |
| `R5_FF2` | Final Four, Game 2 |
| `R6_CH1` | Championship game |

## Auto-Fill Bracket (Chalk)

Fill all 63 picks in one command — always picks the higher seed:

```bash
# Preview what will be submitted (no auth required)
bullpen polymarket bracket fill-chalk <CONTEST_ID> --tiebreaker 145 --dry-run

# Submit for real (round-by-round with verification)
bullpen polymarket bracket fill-chalk <CONTEST_ID> --tiebreaker 145
```

This generates chalk picks (seed 1 beats 16, seed 2 beats 15, etc.) for all rounds. Picks are submitted round by round (R1 first, then R2-R6) with automatic fallback to individual submission if a batch fails. The final pick count is verified by reading back from the server.

After filling with chalk, override specific picks for your upsets:
```bash
bullpen polymarket bracket pick <CONTEST_ID> --slot R1_E2 --winner "TCU"
```

## Fill from JSON File

Submit all picks from a JSON file with fuzzy team name resolution:

```bash
# Preview first
bullpen polymarket bracket fill <CONTEST_ID> --file picks.json --tiebreaker 148 --dry-run

# Submit
bullpen polymarket bracket fill <CONTEST_ID> --file picks.json --tiebreaker 148
```

**JSON format:**
```json
{
  "picks": [
    {"slot": "R1_E1", "winner": "Duke"},
    {"slot": "R1_E2", "winner": "TCU"},
    {"slot": "R1_S1", "winner": "Illinois"}
  ],
  "tiebreaker": 148
}
```

Team names in the JSON file support fuzzy matching — use short names. If the `tiebreaker` field is in the JSON, it overrides the `--tiebreaker` CLI flag.

## View Bracket Summary

See a compact overview of your bracket — champion, Final Four, Elite 8, key upsets, and pick count:

```bash
bullpen polymarket bracket summary <CONTEST_ID>
```

Example output:
```
Champion:   Arizona
Final Four: Michigan St. (E) | Arizona (W) | Iowa St. (MW) | Illinois (S)
Elite 8:    Duke (E) | Michigan St. (E) | Arizona (W) | ...
Upsets:     TCU(9)>Ohio St.(8), USF(11)>Louisville(6)
Picks:      63/63
Tiebreaker: 148
```

## Submit Tiebreaker

Submit or update your tiebreaker score prediction (total points in championship game):

```bash
bullpen polymarket bracket submit <CONTEST_ID> --tiebreaker <SCORE>
```

```bash
# Predict 145 total points in the championship
bullpen polymarket bracket submit march-madness-2026 --tiebreaker 145
```

Submit the tiebreaker after filling all 63 picks. The tiebreaker resolves ties in the final standings.

## View Leaderboard

See the contest standings (top participants, scores, rank):

```bash
bullpen polymarket bracket leaderboard <CONTEST_ID>
bullpen polymarket bracket leaderboard <CONTEST_ID> --limit 20
bullpen polymarket bracket leaderboard <CONTEST_ID> --output json
```

## View Your Status

Check your current rank and score:

```bash
bullpen polymarket bracket status <CONTEST_ID>
bullpen polymarket bracket status <CONTEST_ID> --output json
```

JSON output includes: `rank`, `score`, `max_possible`, `picks_correct`, `picks_remaining`, `tiebreaker`.

## View Game Results

See actual game outcomes to understand which picks scored:

```bash
bullpen polymarket bracket results <CONTEST_ID>
bullpen polymarket bracket results <CONTEST_ID> --round 1
bullpen polymarket bracket results <CONTEST_ID> --output json
```

## View Polymarket Market Mappings

See how each bracket game maps to a Polymarket market (token IDs, slugs, prices):

```bash
bullpen polymarket bracket markets <CONTEST_ID>
bullpen polymarket bracket markets <CONTEST_ID> --output json
```

Useful for cross-referencing bracket picks with Polymarket trading opportunities.

## March Madness Bracket Structure

64-team NCAA tournament organized into 4 regions:

| Region | Seeds |
|--------|-------|
| East | 1–16 |
| West | 1–16 |
| South | 1–16 |
| Midwest | 1–16 |

**Rounds and scoring:**

| Round | Games | Points per correct pick |
|-------|-------|------------------------|
| First Round (R1) | 32 | 1 |
| Second Round (R2) | 16 | 2 |
| Sweet 16 (R3) | 8 | 4 |
| Elite 8 (R4) | 4 | 8 |
| Final Four (R5) | 2 | 16 |
| Championship (R6) | 1 | 32 |

**Total:** 63 picks, maximum 192 points (if all picks correct).

**Seeding shorthand:** Seed 1 is the strongest team; seed 16 is the weakest. Round 1 matchups: 1 vs 16, 2 vs 15, 3 vs 14, 4 vs 13, 5 vs 12, 6 vs 11, 7 vs 10, 8 vs 9.

## AI-Assisted Bracket Filling Workflow

### Step 1: Discover the active contest

```bash
bullpen polymarket bracket contests --status open --output json
```

Note the `contest_id` for use in subsequent commands.

### Step 2: Start with chalk base

```bash
bullpen polymarket bracket fill-chalk <CONTEST_ID> --tiebreaker 145
```

This fills all 63 picks with higher-seed wins. Now you have a complete bracket to customize.

### Step 3: Override with your picks

Apply upsets and personal picks over the chalk base:

```bash
# Pick some R1 upsets
bullpen polymarket bracket pick <CONTEST_ID> --slot R1_E2 --winner "TCU"
bullpen polymarket bracket pick <CONTEST_ID> --slot R1_S4 --winner "McNeese"

# Override later rounds — the CLI warns about inconsistencies
bullpen polymarket bracket pick <CONTEST_ID> --slot R6_CH1 --winner "Arizona"
```

Or submit all overrides at once from a JSON file:
```bash
bullpen polymarket bracket fill <CONTEST_ID> --file my_upsets.json
```

### Step 4: Review your bracket

```bash
bullpen polymarket bracket summary <CONTEST_ID>
```

### Step 5: Verify all picks

```bash
bullpen polymarket bracket picks <CONTEST_ID>
```

Confirm all 63 slots are filled and the summary looks right.

## Strategy Templates

### Chalk (favor higher seeds)

Pick the team with the better seed in every game. Maximizes expected correct picks but leaves points on the table if there are upsets.

```
Round 1: always pick the lower seed number (seed 1 beats 16, seed 2 beats 15, etc.)
Champion: pick the overall #1 seed
```

### Upset-Heavy (2–3 upsets per round in early rounds)

Target statistically common upsets:
- 5 vs 12: 12-seeds win ~35% historically — strong upset candidate
- 10 vs 7: 10-seeds win ~40% historically
- 11 vs 6: 11-seeds win ~37% historically
- 13 vs 4: 13-seeds win ~21% historically

Sprinkle in 2–3 of these per region. Avoid picking upsets in Sweet 16 or later unless you have strong conviction.

### Custom Champion (work backwards)

1. Pick your champion first (`R6_CH1`).
2. Work backwards: your champion must win both Final Four games, their Elite 8 game, etc.
3. Fill the rest of the bracket to support your champion's path, then fill other regions freely.

Use this when you have strong conviction on a champion that is not the consensus favorite (creates differentiation from the field).

### Contrarian (maximize differentiation)

1. Get the contest leaderboard structure if available.
2. Pick a non-consensus champion (e.g., a 3 or 4 seed).
3. Pick several 12-seed upsets in Round 1.
4. This maximizes upside in a large-field contest where differentiation matters more than raw accuracy.

## Automated Full-Bracket Fill Script

The simplest approach uses the built-in `fill-chalk` command:

```bash
#!/usr/bin/env bash
# Fill an entire bracket using chalk strategy (always pick higher seed)
CONTEST_ID="$1"

# One command fills all 63 picks + sets tiebreaker
bullpen polymarket bracket fill-chalk "$CONTEST_ID" --tiebreaker 145

# Review the result
bullpen polymarket bracket summary "$CONTEST_ID"
```

For a custom bracket from a JSON file:

```bash
#!/usr/bin/env bash
CONTEST_ID="$1"

# Start with chalk base, then override with custom picks
bullpen polymarket bracket fill-chalk "$CONTEST_ID" --tiebreaker 148
bullpen polymarket bracket fill "$CONTEST_ID" --file my_picks.json

# Review
bullpen polymarket bracket summary "$CONTEST_ID"
echo "Bracket complete!"
bullpen polymarket bracket picks "$CONTEST_ID"
```

## Cross-References

- **Trade on bracket outcomes**: See `references/trading.md` for buying/selling shares on related Polymarket markets
- **Track scores live**: Use `bullpen polymarket bracket results <CONTEST_ID>` during the tournament
- **Authentication required**: See `references/getting-started.md` if not logged in
