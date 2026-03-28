# LiveView Notes

## Lifecycle

1. `phx-mounted` runs when the element mounts.
2. It does not rerun just because assigns changed later.
3. If a modal stays in the DOM and only visibility changes, use a hook for update-driven behavior.

## Focus And Modal Behavior

1. Scope focus targets to the modal root, not a broad selector like `"form"`.
2. If a modal is conditionally rendered, `phx-mounted` can be enough.
3. If a modal stays mounted, use a hook with `mounted()` and `updated()`.
4. Prefer server-state clarity over fragile JS selector assumptions.

## Role Of LiveViews

1. Keep LiveViews focused on orchestration and rendering.
2. Extract flow or form modules when interactions stop being trivial.
3. Keep rendering, event coordination, and lower-level behavior at distinct abstraction levels.

## Template And JS Rules

1. Use HEEx correctly for attributes and blocks.
2. Use `<.form>` and `to_form(...)` for forms.
3. Add stable IDs to forms, buttons, and modal roots.
4. Avoid inline script tags; use hooks in `assets/js` when behavior must react to state changes.
5. Prefer grouped `class={[...]}` chunks when writing non-trivial class lists.
6. Let class grouping reflect intent, not just raw accumulation of utilities.
7. If the project already uses DaisyUI or another component system, start with its minimal classes and layer in utilities only when needed.
8. Prefer alphabetical ordering for component attributes when there is no stronger semantic grouping reason.

## Collections

1. Use streams for dynamic collections in LiveView.
2. Re-stream items when assign-dependent content inside a stream must change.
3. Track counts and empty-state signals outside the stream itself.

## General Examples

1. Thin orchestration-focused LiveView:
   1.1. load state
   1.2. render
   1.3. delegate detailed interaction handling to smaller modules when needed
2. Extracted flow and form modules:
   2.1. `FlowMoveNode`
   2.2. `FormAddChild`
3. Shared local helper family:
   3.1. `Helpers`
4. Modal lifecycle:
   4.1. use a hook when the DOM stays mounted and visibility toggles
5. Alphabetical component-attribute ordering:
   5.1. list attributes alphabetically unless a stronger semantic grouping improves readability
