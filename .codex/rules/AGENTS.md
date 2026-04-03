<!-- - Keep AGENTS.md constraints in mind (LiveView templates, Tailwind usage, no inline scripts). -->
<!-- - Check for the presence of notes/OVERVIEW.md; if it exists, read it. -->
- Ask for clarifications before proceeding with any changes.
- Act as a critic; look for potential flaws in your reasoning and mine.
- Always number your points (sub-points too: 1.1, 1.2, ...).

# git rules

1. The agent may run only read-only git commands without asking (e.g. git status, git diff, git log, git show, git blame).

2. The agent is forbidden from running git commands that change repo state (e.g. git add, git commit, git reset, git restore, git checkout, git rebase, git merge, git cherry-pick, git clean, git stash, git push) unless I explicitly instruct it to run that specific command.

# Critically Important (highest priority)

- Follow user directives verbatim. Do not expand scope or “improve” unless explicitly requested.
- Ambiguity → ask, do nothing until clarified.
- Questions vs. commands are distinct:
  - If a message ends with a question mark, treat it as a question: answer only; do not change files or run
      commands.
  - A command uses explicit verbs (e.g., add/create/move/delete/rename/edit/replace/format/build/test/run/
      compile/install/apply/do). Execute only when stated explicitly.
  - If a message mixes question + request, ask for clarification and do nothing until the command is explicit.
  - If unsure whether it’s a question or a command, ask first; do not act.
- Restate the confirmed scope before acting on multi-step requests; pause after completion.

  # Coding Style

1. Consent & Scope

- Ask before changing; stay within agreed constraints; don’t stage/commit unless told.

2. Clarity & Self-Documentation

- Prefer explicit names, clear data shapes, and straightforward flow so code reads itself.
- Store truth, derive the rest.
- Prefer direct, honest code over ceremony.
- Functions are either doers (focused tasks) or orchestrators (high-level sequencing of doers); keep this
  layering balanced, not over-nested.
- Comment intent only when non-obvious; avoid noise.

3. Separation of Concerns

- Small, focused modules; avoid bloated files and hidden barrels.
- Extract only for real boundaries.
- Keep code local to where it is valid.
- Keep imports/exports explicit; minimal public surface.

4. Correctness via Constraints

- Enforce invariants with schema/structural rules and validators; block bad states early.
- Runtime guards/sanitizers are backstops; ad-hoc patches are last resort.

5. Honest, Safe Behavior

- UI/options reflect what’s valid; disable/omit invalid actions.
- Fail gracefully; add fallbacks/try-catch only as last resort.

6. Maintainability

- Predictable, flat-ish layout; clear helper extraction when code grows.
- When in doubt, prefer deleting a layer over adding one.
- Avoid unnecessary abstractions or cleverness; keep code easy to follow.

7. Transparency & Hygiene

- Communicate risks/assumptions succinctly; respect existing state/warnings unless directed.
- Run builds/tests when requested; fix new errors; don’t mask preexisting warnings unless asked.

8. Consistent Patterns

- Reuse established project patterns (context-aware UI gating, helper extraction, structural guards).
- Prefer minimal folders/index files; name files by responsibility (e.g., sanitize-doc.ts).

Note: Adapt to the project’s framework conventions (e.g., Phoenix LiveView, Tailwind) when present.

9) Questions vs. Commands

- If a message ends with a question mark, treat it as a question: answer only; do not change files or run commands.
- Commands use explicit verbs (add/create/move/delete/rename/edit/replace/format/build/test/run/compile/install/apply/do). Execute only when stated explicitly.
- If a message mixes question + request, ask for clarification; do nothing until the command is explicit.
- If unsure whether it’s a question or a command, ask first; do not act.
- Restate confirmed scope before acting on multi-step requests.

10) Investigation Initiative

- You may proactively inspect project structure and file contents to answer questions without asking for clarification when the answer is discoverable.

