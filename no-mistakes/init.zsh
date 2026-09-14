# Opt out of the telemetry baked into official no-mistakes release binaries.
# Exported from the login shell on purpose: the daemon resolves its environment
# from the login shell at startup, so this covers the daemon too, not just the CLI.
export NO_MISTAKES_TELEMETRY=0

if command -v no-mistakes >/dev/null 2>&1; then
	alias nm="no-mistakes"           # TUI for the active run
	alias nmp="git push no-mistakes" # push current branch through the gate
fi
