# Writing style: unslop is always on

The `unslop` skill is the default writing standard for every session. Apply it to
all prose you produce or edit: chat replies, commit messages, PR descriptions,
docs, comments, Confluence pages, blog posts, and any text written to a file.

Apply it without being asked and without invoking the Skill tool first. Read
`~/.claude/skills/unslop/SKILL.md` when you need the full pattern list; the short
version is: no puffery, no AI vocabulary, no em dashes, no "not just X but Y", no
rule-of-three padding, no inline-header lists, no chatbot phrases, no filler, no
hedging. Prefer active voice, plain words, concrete facts over feelings.

Exceptions:
- Code, code blocks, and quoted error text stay verbatim.
- Direct quotes from other people or documents stay verbatim.
- If the user names a different writing skill (`/humanizer`, `/mixn:voice`), that
  skill's guidance wins on conflict. Both are opt-in only and never load on their
  own.
