Type: Trust Badge as a block
Description: A container with light background color (#f5f5f5 to #f9f9f9), padding and border-radius separated into two parts (top and bottom) with a thin line. Top row shows 3 badges (each with a simple Lucide icon and short text), bottom row shows 7 payment icons using Shopify native liquid payment_type_svg_tag. Both rows arranged in equal-width columns (1/amount of objects = the percentage every object gets), stacked vertically.


Common Mistakes

### Mistake 1: Using min-width on flex items
NEVER use min-width on flex items - this prevents responsive resizing. ALWAYS use max-width only.

### Mistake 2: Using fixed widths or CSS Grid auto-fit
NEVER use fixed widths or CSS Grid auto-fit. Always use flexbox with percentage-based flex-basis that factors in the gap (flex: 1 1 calc(X% - Ygap)) and max-width constraints for payment icon grids. no: flex-wrap: wrap → yes: flex-wrap: nowrap

### Mistake 3: Inaccurate gap calculations
Gap calculations must accurately reflect the actual gap value. For gap: 16px use 11px in calc, for gap: 0.75rem use 0.5rem in calc.

### Mistake 4: Using shop.enabled_payment_types
NEVER use shop.enabled_payment_types. CRITICAL: Use hardcoded payment types: {%- assign payment_types = 'visa,master,paypal,american_express,diners_club,discover,maestro' | split: ',' -%}

### Mistake 5: Hardcoding design values
All visual values (colors, spacing, sizing) must be customizable through block.settings with CSS custom properties - never hardcode design values in CSS.

### Mistake 6: making up your own icons
use lucide icons. lucide.dev → find icon → click "Copy SVG" → paste directly into .liquid file between HTML tags

Implementation

1. Container: Add light background color (#f5f5f5 to #f9f9f9) with padding and border-radius to make the entire container visible.

2. Trust Badges Row (top): Use display: flex, justify-content: space-between, set each item to flex: 1 1 calc(33.333% - Xgap) with matching max-width: calc(33.333% - Xgap) where Xgap is calculated from gap value (e.g., for gap: 16px use 11px in calc, for gap: 0.75rem use 0.5rem in calc).

3. Payment Icons Row (bottom): Use display: flex, justify-content: space-between OR center, set each icon to flex: 1 1 calc(14.285% - Ygap) with matching max-width: calc(14.285% - Ygap) where Ygap follows the same gap calculation logic.

4. Payment Types: Use hardcoded payment types: {%- assign payment_types = 'visa,master,paypal,american_express,diners_club,discover,maestro' | split: ',' -%} and render with payment_type_svg_tag.

5. Separation: Add a thin line between top and bottom rows.

6. No hard pixel minimum limit - all should scale based on container width - Uses max-width: var(--ec-payment-icon-max-width, 45px); on the SVG itself - (it should not break into two rows)

7. Settings: Make all visual values (colors, spacing, sizing) customizable through block.settings with CSS custom properties.



