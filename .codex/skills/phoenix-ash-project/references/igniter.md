# Igniter Notes

## When To Load This

1. Load this file when installing dependencies in Ash projects.
2. Load this file when upgrading dependencies where codemods or upgrade tasks may exist.
3. Load this file when renaming functions.
4. Load this file when planning a module-level refactor that Igniter may help with partially.

## Assumption

1. In Ash projects, assume `igniter` is available unless local project inspection shows otherwise.

## Install

1. Prefer `mix igniter.install` when adding dependencies that may provide installers.
2. Basic usage:
   2.1. `mix igniter.install package1 package2`
3. Supported package forms include:
   3.1. `package`
   3.2. `package@version`
   3.3. `package@git:git_url`
   3.4. `package@git:git_url@ref`
   3.5. `package@github:org/repo`
   3.6. `package@github:org/repo@ref`
   3.7. `package@path:path/to/dep`
   3.8. `org/package`
4. Important flags:
   4.1. `--only`
   4.2. `--dry-run`
   4.3. `--yes`
   4.4. `--yes-to-deps`
   4.5. `--verbose`
   4.6. `--example`
5. Caveat:
   5.1. if using `--only`, `MIX_ENV` must match one of those environments
   5.2. example: `MIX_ENV=dev mix igniter.install ash --only dev`

## Upgrade

1. Prefer `mix igniter.upgrade` over raw `mix deps.update` when package upgrade tasks may matter.
2. Basic usage:
   2.1. `mix igniter.upgrade package1 package2@1.2.1`
3. Important flags:
   3.1. `--yes`
   3.2. `--all`
   3.3. `--only`
   3.4. `--verbose`
   3.5. `--target`
   3.6. `--no-archives-check`
   3.7. `--git-ci`
4. Caveats:
   4.1. the target version must still be compile-compatible with the current codebase
   4.2. if Igniter or its dependencies are part of the upgrade set, Igniter may stop and instruct you to run `mix igniter.apply_upgrades ...`
   4.3. `--git-ci` uses git history logic and implies `--yes`
   4.4. environment-limited deps may require rerunning with a matching `MIX_ENV`

## Rename Function

1. Prefer `mix igniter.refactor.rename_function` for function renames before doing a manual project-wide rename.
2. Basic usage:
   2.1. `mix igniter.refactor.rename_function OldModule.old_fun NewModule.new_fun`
3. Function formats:
   3.1. `Mod.fun`
   3.2. `Mod.fun/arity`
4. Arity rules:
   4.1. if the old function includes arity and the new function omits it, Igniter uses the old arity
   4.2. if both include arity, they must match
   4.3. if old omits arity, Igniter treats it as `:any`
5. Deprecation option:
   5.1. `--deprecate soft`
   5.2. `--deprecate hard`
6. Behavior:
   6.1. renames definitions, calls, and references
   6.2. can move a function to a new module
   6.3. creates the destination module if it does not exist
7. Limitation:
   7.1. it cannot reliably catch dynamic `apply/3` usage

## Module Renaming

1. Do not assume a dedicated `mix igniter.refactor.rename_module` task exists.
2. Igniter's built-in refactor support is function-centric, not module-centric.
3. For a broader module rename:
   3.1. use `mix igniter.refactor.rename_function` to move relevant functions where useful
   3.2. then manually handle module-definition renames
   3.3. manually clean up remaining pure module-name references
