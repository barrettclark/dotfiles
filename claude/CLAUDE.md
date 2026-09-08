# Global Claude Instructions

## User Preferences

- Address the user as **Barrett**, not "user" or "you" (when a name is natural to use).

## Git Commit Permissions

- **Never commit or push without explicit permission.** Barrett reviews diffs before committing.
- Permission granted in a conversation **expires after 4 hours of inactivity** and must be re-confirmed.
- Permission is scoped to what was asked — approval to commit one change does not cover unrelated changes.
- Always ask before restarting services or containers, even if a restart would fix an obvious problem.

## General

- Prefer thorough, correct implementations over speed. No sloppy work.
- Keep responses concise. Skip preamble and summaries of what was just done.

## Code Comments

- Favor short, sparse comments. Default to no comment; when one is needed, one or
  two lines. "Comments are most useful when they're concise and focused on the
  non-obvious parts, especially the why, trade-offs, or constraints that aren't
  clear from the code itself" (semohr). Same for docstrings — brief, not exhaustive.
- Don't narrate what the code does or add meta-text ("see below"). No verbose,
  LLM-style comment blocks — they drift and bury the important lines.
- Keep design decisions and fuller rationale in the PR description (or review
  replies), not in code, unless the code genuinely can't be understood without it.
