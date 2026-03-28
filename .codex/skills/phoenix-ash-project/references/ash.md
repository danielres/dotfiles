# Ash Notes

## First Checks

1. Identify the resource action.
2. Identify the domain `define` wrapper, if any.
3. Match the call site to the exact accepted attrs and args.
4. Check whether the operation expects `scope`, `actor`, `tenant`, or a form-backed submit path.

## Decision Rules

1. Prefer `AshPhoenix.Form` for normal create or update UI flows when the form shape maps cleanly to the action.
2. Drop to direct domain or resource calls when the workflow is unusual, multi-step, or not naturally form-shaped.
3. Prefer `scope: scope` when the surrounding code already uses that pattern.
4. Keep related Ash-facing collaborators API-consistent when they belong to one flow family.

## Common Failure Modes

1. Positional args and options are shifted into the wrong slots in code-interface calls.
2. `actor` never reaches `relate_actor(...)`, so required relationships fail.
3. Tenant is required by multitenancy but not passed through the expected API.
4. A helper returns updated data in memory, but nothing persists it.
5. Validation errors are hidden by `{:ok, value} = ...` matches that crash first.

## Preferred Approach

1. Compare the failing code with a known-good AshPhoenix form flow already present in the project, if one exists.
2. When debugging create or update actions:
   2.1. inspect `accept [...]`
   2.2. inspect `argument ...`
   2.3. inspect relationship changes like `relate_actor(...)`
   2.4. inspect multitenancy configuration
3. For multi-step writes, verify each step actually persists.
4. Favor API consistency across related collaborators when it improves predictability.
5. Be wary of one-off Ash call shapes inside a flow family when neighboring modules use a shared pattern.

## General Examples

1. AshPhoenix form flow:
   1.1. `Form.for_create(...) |> to_form()`
   1.2. `Form.submit(...)`
2. Ash change layer wrapping pure logic:
   2.1. `Changes.AddChild`
   2.2. `TreeOps.AddChild`
3. Code-interface definition example:
   3.1. `define :create_thing, action: :create, args: [...]`
4. Multitenant write example:
   4.1. `SomeDomain.create_thing(..., scope: scope)`
