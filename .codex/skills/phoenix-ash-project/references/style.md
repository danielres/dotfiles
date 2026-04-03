# Style Notes

## Primary Goal

1. Optimize for ease of maintenance over time.
2. Minimize cognitive load for future readers.
3. Make the codebase easy to navigate, not just locally readable.

## Progressive Disclosure

1. A reader should understand the broad picture first.
2. Details should be discoverable by zooming in step by step.
3. Top-level modules should read like maps of the feature.
4. Extracted modules should carry focused detail and little unrelated context.

## Orchestrators And Doers

1. Prefer code that orchestrates the big picture in one place.
2. Move detailed logic into smaller doer modules.
3. Keep one abstraction level per file where practical.
4. Do not let orchestration files drown in implementation detail.

## Local Readability

1. Rebind frequently used values locally when it keeps the main lines of logic shorter and easier to scan.
2. Prefer short local names like `scope` or `page_tree` when they remove repeated long access paths such as `socket.assigns.current_scope`.
3. Use this to clarify the main flow, not merely to save keystrokes.

## Left-To-Right Flow

1. Prefer subject-on-the-left code when it makes the flow easier to scan.
2. Favor left-to-right progression over nested call shapes when the pipeline stays readable.
3. Use pipelines to make value transformation explicit, not just to force every call into pipe form.
4. Prefer the style that makes the data movement easiest to follow.

## Splitting Rules

1. Extract early when it clearly improves readability.
2. Do not split so aggressively that navigation moves from inside files to the filesystem.
3. A `Helpers` module can hold multiple helpers for one local concern.
4. Split a helper family only once a stronger boundary becomes meaningful.

## Naming And Symmetry

1. Prefer object-first names when that improves grouping and scanability.
2. Keep operation names stable across parallel layers when the conceptual action is the same.
3. Let namespaces communicate responsibility boundaries.
4. Keep module names as direct reflections of file paths by default.
5. Favor consistency across related APIs even when not strictly required by implementation.
6. Allow small amounts of redundancy when they improve symmetry and predictability.

## Stable Ordering

1. Prefer alphabetical ordering for list-like declarations when there is no stronger grouping reason.
2. Apply this especially to:
   2.1. `alias` blocks
   2.2. `attr` definitions
   2.3. HEEx component attributes
3. Use a different order only when a stronger semantic grouping clearly improves readability.

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

1. Object-first naming:
   1.1. `FormAddChild`
   1.2. `FlowMoveNode`
2. Parallel operation naming across layers:
   2.1. `Changes.AddChild`
   2.2. `TreeOps.AddChild`
3. Local readability via rebinding:
   3.1. `scope = socket.assigns.current_scope`
   3.2. `page_tree = socket.assigns.page_tree`
4. Left-to-right flow:
   4.1. `node |> Wiki.create_page_for_node(scope: scope)`
   4.2. `page |> Ash.load([:author], scope: scope)`
5. HEEx class grouping:
   5.1. `class={["absolute right-2 top-2", "size-4 text-xs", "cursor-pointer", "opacity-50 hover:opacity-100 transition"]}`
6. Stable ordering:
   6.1. alphabetized `alias` blocks
   6.2. alphabetized `attr` declarations
   6.3. alphabetized component attributes when no stronger grouping exists

## Working Rules

1. Follow local project instructions before anything else.
2. Ask for clarification before changes when scope is ambiguous.
