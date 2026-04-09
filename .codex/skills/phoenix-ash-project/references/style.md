# Style Notes

## Primary Goal

1. Optimize for ease of maintenance over time.
2. Minimize cognitive load for future readers.
3. Make the codebase easy to navigate, not just locally readable.
4. Store truth, derive the rest.
5. Default to directness; abstraction must justify itself.

## Progressive Disclosure

1. A reader should understand the broad picture first.
2. Details should be discoverable by zooming in step by step.
3. Top-level modules should read like maps of the feature.
4. Extracted modules should carry focused detail and little unrelated context.

## Orchestrators And Doers

1. Prefer code that orchestrates the big picture in one place.
2. Move detailed logic into smaller doer modules.
3. Keep one abstraction level per file where practical.
4. Prefer one clear orchestration point over several thin wrappers that distribute the same flow.
5. Prefer data-oriented helper signatures over passing framework objects, unless the helper is framework-specific.
6. Do not let orchestration files drown in implementation detail.
7. Keep each layer focused on its actual responsibility.
8. Reuse logic from the most specific existing owner instead of rebuilding it locally.
9. Reuse basic lookups and operations from the real owner instead of recreating them in a higher layer.
10. Keep helpers local only when they are truly local and would not clarify another module.
11. When a value changes shape only because of a boundary or framework constraint, perform that adaptation at that boundary, not deeper in the system.

## Local Readability

1. Rebind frequently used values locally when it keeps the main lines of logic shorter and easier to scan.
2. Prefer short local names like `scope` or `page_tree` when they remove repeated long access paths such as `socket.assigns.current_scope`.
3. Use this to clarify the main flow, not merely to save keystrokes.

## Left-To-Right Flow

1. Prefer subject-on-the-left code when it makes the flow easier to scan.
2. Favor left-to-right progression over nested call shapes when the pipeline stays readable.
3. Use pipelines to make value transformation explicit, not just to force every call into pipe form.
4. Prefer the style that makes the data movement easiest to follow.
5. When in doubt, prefer deleting a layer over adding one.

## Splitting Rules

1. Extract when it clearly improves readability.
2. Extract only for real boundaries.
3. Prefer inline code over one-use trivial helpers.
4. Use well-named local variables to clarify a short local flow before reaching for a helper extraction.
5. Do not extract one-use helpers that only move code around or rename obvious code.
6. Do not generalize for hypothetical future needs unless there is already real pressure.
7. Do not split so aggressively that navigation moves from inside files to the filesystem.
8. A `Helpers` module can hold multiple helpers for one local concern.
9. Split a helper family only once a stronger boundary becomes meaningful.

## Naming And Symmetry

1. Prefer object-first names when that improves grouping and scanability.
2. Keep operation names stable across parallel layers when the conceptual action is the same.
3. Let namespaces communicate responsibility boundaries.
4. Keep module names as direct reflections of file paths by default.
5. Name helpers after their real contract: what they return or what they mutate.
6. Prefer verb-led function names by default, since functions usually perform an action.
7. Allow noun or transformation names when they are the most direct and obvious reading.
8. Prefer `x_to_y` naming over `y_from_x` for transformations when the `to` form is shorter and reads more naturally.
9. Make contracts honest: do not rely on hidden preloaded state or vague naming.
10. Favor consistency across related APIs even when not strictly required by implementation.
11. Allow small amounts of redundancy when they improve symmetry and predictability.
12. In codebases that use the convention, prefer `get_*` for result tuples and `load_*` for nil/empty fallback APIs.
13. Prefer aliasing stable namespaces over one-off renamed leaf modules when that keeps responsibility clearer, for example alias `Qblog.Wiki.PageTree.TreeOps` and call `TreeOps.RemoveNode.call(...)` instead of aliasing `...RemoveNode` as a special local name.
14. Prefer qualified names over generic aliases when the qualification materially improves clarity at the call site.

## Stable Ordering

1. Prefer alphabetical ordering for list-like declarations when there is no stronger grouping reason.
2. Apply this especially to:
   2.1. `alias` blocks
   2.2. `attr` definitions
   2.3. HEEx component attributes
3. Use a different order only when a stronger semantic grouping clearly improves readability.

## State And Locality

1. Store primary facts and derive secondary UI states from them when practical.
2. Avoid parallel tagged state when concrete assigns already express the truth.
3. Avoid re-deriving the same truth in multiple places when one clear source is already available.
4. Resolve from the closest truth: prefer already-held server data before re-querying.
5. Pass small stable identifiers across boundaries and resolve richer objects on the server.
6. In code and data structures we own, decide the expected shape and code directly to it.
7. Do not add defensive branches for alternate internal shapes unless those shapes are genuinely intended to be supported.
8. Keep UI and logic local to the state where they are valid.
9. Avoid globally rendered structures that require compensating event logic elsewhere.

## Common Failure Modes

1. Do not introduce proxy state when concrete data already expresses the truth.
2. Do not add one-use helpers that only move obvious code around.
3. Do not spread one flow across several thin orchestration wrappers.
4. Do not rebuild resource-owned lookups or operations in higher layers.
5. Do not require hidden preloaded state from callers.
6. Do not globally render UI that is only valid in one state.
7. Do not re-derive the same source of truth in multiple places.
8. Do not add defensive branches for alternate shapes in code and data structures we own unless we truly intend to support them.
9. Do not generalize for hypothetical reuse before real pressure exists.

## HEEx Class Style

1. Prefer `class={[...]}` when multiple classes are present, even when no conditionals are needed.
2. Group related classes into short chunks rather than one long string.
3. Use the chunks to communicate intent, for example:
   3.1. positioning
   3.2. sizing
   3.3. interaction
   3.4. visual state
4. Favor scanability over compactness.
5. Do not create artificial fragmentation when a single short class string is already clear.

## DaisyUI And Tailwind

1. If a project uses DaisyUI or a theme system, treat it as the baseline styling layer.
2. Start with minimal component classes such as `btn`, `btn-primary`, `card`, or `modal` when they exist.
3. Add utility classes only when the baseline component system does not express the needed structure or refinement.
4. Avoid over-styling elements that the active theme already handles well.
5. Prefer minimal, theme-aware styling over bespoke utility piles.

## General Examples

1. Truth over proxy state:
   1.1. prefer matching on concrete data when it already expresses the state
   1.2. avoid parallel tagged state that duplicates those facts
2. Real boundary extraction:
   2.1. prefer inline code until a helper hides real complexity or names a real responsibility
   2.2. prefer well-named local variables over one-use trivial helpers when the flow is already local
   2.3. avoid one-use helpers that only move obvious code around
3. Directness over ceremony:
   3.1. prefer the simpler direct version until an abstraction clearly earns its keep
   3.2. avoid designing for hypothetical flexibility before real pressure exists
4. Responsibility boundaries:
   4.1. keep orchestration in the current layer, but reuse specialized logic from the most specific existing owner
   4.2. keep helpers local only when they are truly local to that file or feature
   4.3. when a value changes shape only because of a boundary constraint, adapt it at that boundary
5. Single orchestrator over layered orchestration:
   5.1. prefer one clear orchestrator that sequences the flow in one place
   5.2. avoid several thin wrappers that each forward part of the same flow
6. Object-first naming:
   6.1. `FormAddChild`
   6.2. `FlowMoveNode`
7. Parallel operation naming across layers:
   7.1. `Changes.AddChild`
   7.2. `TreeOps.AddChild`
8. Local readability via rebinding:
   8.1. `scope = socket.assigns.current_scope`
   8.2. `page_tree = socket.assigns.page_tree`
9. Left-to-right flow:
   9.1. `node |> Wiki.create_page_for_node(scope: scope)`
   9.2. `page |> Ash.load([:author], scope: scope)`
10. Verb-led function naming:
   10.1. prefer `move_block_up`
   10.2. prefer `destroy_placed_block`
   10.3. avoid noun-like names for actions when a clear verb exists
11. Transformation naming:
   11.1. prefer `param_to_type`
   11.2. prefer `jpg_to_png`
   11.3. over heavier `type_from_param` style when the `to` form is clearer
12. Qualified names over generic aliases:
   12.1. prefer `Blocks.Components.form`
   12.2. over a generic local alias like `Components.form` when the fuller name is clearer
13. HEEx class grouping:
   13.1. `class={["absolute right-2 top-2", "size-4 text-xs", "cursor-pointer", "opacity-50 hover:opacity-100 transition"]}`
14. Stable ordering:
   14.1. alphabetized `alias` blocks
   14.2. alphabetized `attr` declarations
   14.3. alphabetized component attributes when no stronger grouping exists

## Working Rules

1. Follow local project instructions before anything else.
2. Ask for clarification before changes when scope is ambiguous.
