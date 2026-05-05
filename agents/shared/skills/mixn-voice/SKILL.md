---
name: mixn:voice
description: |
  Apply Miloš Sutanovac's personal writing voice to any text. Use when writing
  or rewriting blog posts, technical articles, Confluence pages, post-mortems,
  team updates, or any written content that should sound like Miloš wrote it.
  Invoke whenever the user says "in my voice", "make this sound like me",
  "rewrite this", "write a blog post about X", or whenever producing
  internal Confluence posts or technical write-ups for Miloš. Builds on
  humanizr patterns first, then shapes the result to his distinct voice:
  casually authoritative, self-deprecating, practically opinionated,
  technically precise, and collaborative.
---

# mixn:voice — Write Like Miloš

This skill rewrites text to match Miloš Sutanovac's personal voice, as established in his technical blog posts. It first strips AI-generated tells, then shapes the result to fit his style.

---

## What This Voice Sounds Like

Miloš writes like a senior engineer who genuinely enjoys the craft and wants others to as well. The tone is casual but technically sharp — opinionated, self-deprecating, practically focused, and always collaborative.

### Core characteristics

**Casually authoritative.** He owns opinions without hedging. "This post is highly opinionated — extract what you find useful." He doesn't say "it could be argued"; he says "here's what I think." Acknowledges tradeoffs but doesn't waver.

**Self-deprecating, briefly.** Not enough to undermine the content — just enough to be human. "I am that annoying, sorry 😅." Or a parenthetical aside: `(*\*cough\** not talking about myself 🤧 \**cough*\*)`. Or "yes, I used to have a cheat sheet taped to my desk." These are quick flashes, never overdone.

**First-person without apology.** "I", "we", "my" appear naturally. No hiding behind passive voice or "one should" constructions.

**Technical precision.** Uses `backtick notation` for tools, commands, packages, and version numbers — even mid-sentence in prose. Writes `v3`, `npm-groovy-lint`, `concurrently`, `lazygit` — never "version 3", "the groovy lint tool", "the concurrently package."

**Practical storytelling.** Shows the progression of real problems. Version breakdowns (v0, v1, v2...), honest "Remaining problems" sections, before/after comparisons. Never just explains what something is — explains what broke, why it broke, what was tried, and what worked.

**Collaborative and crediting.** Names teammates explicitly. Invites others to contribute. "Please add your favorite tools to the list!" Treats knowledge as something to share, not hoard.

**Varied rhythm.** Mixes short punchy sentences with longer ones. Uses single-sentence paragraphs for emphasis -- "Because your team deserves it." (full stop, new paragraph). Not everything needs to be compound.

**Emojis in section headers** — but only for longer structured posts (Confluence blogs, articles), and only in top-level headers: 📝 TL;DR, 👩‍💻 Developer Experience, ⚡ Improvements, 🎒 Summary, 👋 Introduction. Not in bullet points, not sprinkled randomly. This is his style, not AI slop — preserve it.

**External references, genuinely.** Links to things he actually used or read. Provides context for the link: "I love referencing this video whenever these topics come up" — not just a bare URL.

**Meta-awareness about the writing itself.** "I apologize for the length." "The title may be a bit click-baity." "This will be a living document." He addresses the post's own quirks directly.

**80/20 thinking.** Ships the good-enough solution and says so. "There's always room for improvement 🚀, but any further changes would likely fall under micro-optimizations."

**Sources section at the end** for technical/blog content — always. Not a wall; organized and relevant.

---

## Process

### Step 1: Apply humanizr patterns

Strip AI-generated tells before anything else. Apply `/humanizr` or work through its patterns manually:

- Remove significance inflation: "pivotal moment", "enduring testament", "evolving landscape"
- Remove AI vocabulary: pivotal, crucial, delve, tapestry, underscore, showcase, vibrant, intricate
- Remove generic conclusions: "the future looks bright", "exciting times lie ahead"
- Remove excessive hedging: "could potentially be argued that"
- Remove signposting: "let's dive in", "here's what you need to know", "without further ado"
- Remove rule-of-three overuse and negative parallelisms ("It's not just X; it's Y")
- Remove vague attributions: "experts say", "observers have noted"
- Remove promotional language: "groundbreaking", "nestled", "breathtaking", "boasts"
- Collapse inline-header bullet lists into prose where possible

**Exception — emojis:** preserve or add emojis in top-level section headers for structured blog posts -- this is Miloš's own style, not an AI artifact.

**No em dashes.** Em dash (—) is a strong AI writing signal (humanizr rule #14). Use `--` instead in all cases. Mid-sentence aside: "we -- the Team Alpha team -- implemented...". Clean, human, no encoding headaches.

**Exception — smart quotes:** humanizr rule #19 says to replace curly quotes with straight quotes. Ignore that rule here. In natural language, always use typographic (smart) quotes:
- Single: ' ' (apostrophes and single quotes -- e.g. *someone's plate*, *it's*, *'quoted'*)
- Double: " " (e.g. *"this is a quote"*)

Use straight `'` and `"` only inside code blocks, inline `backtick` spans, shell commands, and anywhere the text will be parsed programmatically.

### Step 2: Apply Miloš's voice

After cleaning, shape the text:

1. **Inject first-person.** Convert "developers should" → "I do" or "you should", depending on whether Miloš is sharing experience or advising the reader.

2. **Ground abstractions in something real.** If a paragraph stays theoretical for more than two sentences, add a concrete thing that actually happened. A version number. A package name. A teammate.

3. **Add a reaction.** After neutral reporting, add a brief human take. "And yes, that's very annoying." "Let that sink in." "It's frustrating." These don't need to be long — one sentence is enough.

4. **Apply `backtick` notation** to every tool, command, package, and version mid-prose.

5. **Vary sentence rhythm.** If all sentences are roughly the same length, break one into a short punchy line + a longer follow-up. Or pull a conclusion out as a standalone paragraph.

6. **Add collaborative signal** where appropriate. An invitation to contribute, a mention of a teammate by name, a pointer to a follow-up thread.

7. **For structured blog posts**, add emoji to top-level section headers. Match the tone:
   - 📝 for summaries/TL;DRs
   - ⚡ for performance/speed topics
   - 👩‍💻 for developer experience
   - 🎒 for closing/summary sections
   - 👋 for introductions
   - 👥 for collaboration/team topics
   - 🛠️ for tools sections

8. **Add a TL;DR section** at the top for longer pieces. Miloš almost always opens with one — short, practical, with the headline lessons.

9. **End with something human.** Not "the future looks bright." Either a dry joke, a self-deprecating one-liner, or a real call to action. "Happy tooling! 🚀" or "In the time it took to write this blog post, I could have built a Jenkins pipeline that deploys coffee directly to my desk. ☕" or just "There's always room for improvement 🚀."

### Step 3: Final voice check

Read the result aloud. Ask: "Does this sound like a person who enjoys their work talking to a colleague over coffee?" If no — find what's still too formal, too neutral, or too assembled, and fix it.

---

## Anti-patterns to avoid

- **Excessive formality.** Not "it is worth noting that." Just "here's a thing."
- **Neutral conclusions.** There's always a human touch at the end. Never close with a safe summary.
- **Anonymous "we".** When Miloš writes "we", he usually means a specific team. Name them. If no real team name is available in the context, use `Team Alpha` as a placeholder -- and always append a hint at the end of the output: `> ⚠️ "Team Alpha" is a placeholder — replace with the actual team name before publishing.`
- **Solutions without failures.** Always show the struggle. The "Remaining problems" section is not weakness — it's honesty.
- **Marketing enthusiasm.** His enthusiasm is real, not polished. "Life-changing, but comes with an incredibly steep learning curve" — not "game-changing revolutionary tool."
- **List overload.** He uses bullet points, but prose paragraphs carry the weight. Don't reduce everything to lists.
- **Generic CTAs.** "Let me know if you have questions" is AI. His CTAs are specific: "add your favorite tools to the list", "share in the corresponding Developers thread."

---

## Example transformation

**AI-generated input:**
> This post explores best practices for developer productivity in terminal environments. Developers who invest time in customizing their terminal tools will see significant improvements in their daily workflows. The following tools have been carefully curated to enhance your development experience and boost efficiency.

**After mixn:voice:**
> ***This post is highly opinionated, based on my personal tools, dotfiles, and preferences — extract what you find useful.*** 😊
>
> Some of these I use hundreds of times a day. Others maybe once a month — but I'm always glad to have them.

---

**AI-generated input:**
> The team implemented several optimizations to reduce pipeline runtime. These improvements included parallelization, conditional stages, and resource management. The results were significant.

**After mixn:voice:**
> Over the last few weeks, we -- the Team Alpha team -- implemented numerous gradual changes to our Jenkins pipelines: better parallelization, conditional stages, smarter resource management, and more.
>
> And yes, the `92%` in the title is technically comparing the slowest and fastest pipelines ever, but it makes for a better title. 🤫 The average improvement is expected to range between 65% and 85%, depending on load and conditions.

> **Note:** "Team Alpha" is a placeholder. Replace with the actual team name from the context before publishing.

---

## Clipboard output

If the user says "copy to clipboard", "copy it", or "to clipboard" — pipe the final output to the clipboard after writing it:

- **macOS:** `pbcopy`
- **Windows / WSL:** `powershell.exe -noprofile -command "Set-Clipboard"` — handles Unicode correctly. Do NOT use `clip.exe`; it mangles UTF-8 smart quotes into mojibake (e.g. `someone's` → `someoneÔÇÖs`).

Example (macOS): `printf '...' | pbcopy`

Example (WSL — write UTF-16 to Windows temp, read with PowerShell):
```python
import subprocess
text = "your output here"
with open('/mnt/c/Windows/Temp/voice_out.txt', 'w', encoding='utf-16') as f:
    f.write(text)
subprocess.run([
    '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe',
    '-noprofile', '-command',
    "Set-Clipboard -Value (Get-Content -Path 'C:\\Windows\\Temp\\voice_out.txt' -Raw -Encoding Unicode)"
])
```

Note: `Set-Clipboard` via stdin does NOT work (PowerShell stdin ≠ pipeline input). The file approach is required. The WSL terminal may display em dashes as `-` in `Get-Clipboard` output — the actual clipboard codepoint is correct (U+2014).

Only do this when explicitly asked. Don't copy automatically.

---

## Context: when to use this

Works well for:
- Confluence blog posts and internal articles
- Technical write-ups, post-mortems, ADRs with personal commentary
- Team updates or Slack messages that need to sound human
- Any AI-drafted content that needs to be "written by Miloš"
- READMEs where a personal voice adds warmth

Not for:
- Formal API documentation or legal text
- One-liners where there's no voice to apply
- Content written by and attributed to someone else
