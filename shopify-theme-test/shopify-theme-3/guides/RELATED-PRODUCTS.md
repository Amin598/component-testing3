# Related Products Guide

This guide covers implementing related products blocks in Shopify themes.

---

## 1. Layout Options

!!!!! DEBUG PANNEL WITH SWITCH IN SCHEMA

### Elements to Include:
- **Product Image** (120x120px recommended)
- **Product Title**
- **Price** (current price)
- **Compare-at Price** (crossed out if exists)
- **Savings Display** (optional)
  - Percentage: "Save 20%"
  - Amount: "Save $10"
- **Add to Cart**
  - Button with text
  - Icon button (cart icon)
  - Floating "+" button (top-right corner for compact layouts)
 
### Layout Types:

#### A. Horizontal Card (Image Left, + quick add to cart top right)
```
┌─────────────────────────────────────┐
│ [IMG]  Title                    [+] │
│        $29.99 $39.99 (Save 25%)     │
└─────────────────────────────────────┘
```
**Best for:** 1 product visible at a time, mobile-friendly

#### B. Vertical Grid (2-4 columns)
```
┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐
│ [IMG]│ │ [IMG]│ │ [IMG]│ │ [IMG]│
│ Title│ │ Title│ │ Title│ │ Title│
│$29.99│ │$29.99│ │$29.99│ │$29.99│
│ [+]  │ │ [+]  │ │ [+]  │ │ [+]  │
└──────┘ └──────┘ └──────┘ └──────┘
```
**Best for:** Desktop, showing multiple products

#### C. Horizontal Slider
```
← [Product 1] [Product 2] [Product 3] →
```
**Best for:** 2-3 visible, swipe on mobile

---

## 2. Questions to Ask User

### Design Style
**Ask:** "Should the related products follow your existing shop design, or would you like a more creative/custom style?"

**Options:**
- **Follow existing design** - Use theme's card styles, buttons, colors
- **Creative/custom** - Unique styling for related products section (Keep font and everything else the same!)
- **Reference based** - "Like (IMAGE)"

### Layout Preference
**Ask:** "Which layout would you prefer?"

**Options:**
- Horizontal cards (1 at a time, scroll)
- Grid (2, 3, or 4 columns)
- Slider with arrows
- Compact list

### Data Source (DONT ASK)
**Ask:** "How should we select related products?"

**Options:**
- Manual selection via metafield (recommended)
- Same collection
- Same product type
- Same tags

### Add to Cart Style (DONT ASK IF LITTLE SPACE ...)
**Ask:** "What style for the add to cart action?"

**Options:**
- Full button with text
- Icon only (cart icon)
- Floating "+" badge (top-right)
- Quick add (variant selector)

---

## 3. Common Pitfalls

Pitfall 1: look always how the add to cart button logic works - with all animation and copy that for the "add to card (button or icon)" 

pitfall 2: Using `.size` instead of `.count`
**Wrong:**
```liquid
{%- if related_products.value.size > 0 -%}
```

**Correct:**
```liquid
{%- if related_products.value.count > 0 -%}
```

**Why:** Reference type lists (like `list.product_reference`) use `.count`, not `.size`.

**ALWAYS:** Use `mcp__shopify-dev__search_docs_chunks` to verify before writing.

---

### ❌ Pitfall #2: Incorrect Add to Cart Form
it should not be a redirect to the product page or open the cart. 
It SHOULD BE: just a simple button to think 

**Why:** Must use Shopify's `form 'product'` tag for proper cart integration.

**ALWAYS:** Check MCP docs: `mcp__shopify-dev__search_docs_chunks` with "liquid product form add to cart"

