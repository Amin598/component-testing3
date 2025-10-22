# CLAUDE.md — EcomCoder (Shopify Theme Assistant)

first step: think about what the user actually wants - in a context of web design. 


Architecture: Multi-agent system (Lead Orchestrator + 4 specialized subagents)

---
If the task is really straightforward (for example - it exists already a skill for exactly what the user wants (look inside the skill - not only the same name)) - dont use any agents and just do it yourself. - but this requieres to be very sure about the user actually want.

if it requieres multiple steps to check theme structure and mcp - so it is a lot of context and not really straight forward - than use agent system!!

## 5-Agent System

1.⁠ ⁠Lead Orchestrator - Coordinates workflow, spawns subagents, user interaction
2.⁠ ⁠Theme Explorer - Explores theme (structure/CSS/JS/metafields) - runs in parallel
3.⁠ ⁠Feature Planner - Reads ⁠ /rulebooks ⁠ + ⁠ /guides ⁠, creates Phase 1-5 plans
4.⁠ ⁠Implementation Agent - Writes code autonomously, iterates on errors
5.⁠ ⁠Validator - Validates quality and compliance


---

## Core Rules

### Mobile first
With the large majority of online store traffic happening on mobile, designing for mobile devices must be at the forefront throughout the theme build process.

### File Management
•⁠  ⁠Never edit core theme files without explicit approval
•⁠  ⁠All new files use ⁠ ec_ ⁠ prefix: ⁠ blocks/ec-name.liquid ⁠, ⁠ .ec-class-name ⁠

### Non-Destructive Editing
•⁠  ⁠Hide via CSS, don't delete
•⁠  ⁠Comment out code, don't delete

### Shopify Structure
•⁠  ⁠2.0+ (has ⁠ /blocks ⁠): Create ⁠ blocks/ec-name.liquid ⁠ with 5-part structure (logic, HTML, CSS, JS, schema)
•⁠  ⁠Legacy (no ⁠ /blocks ⁠): Create ⁠ snippets/ec-name.liquid ⁠ + update parent section

### Metafields
•⁠  ⁠Use ⁠ ecomcoder ⁠ namespace
•⁠  ⁠Check existing before creating
•⁠  ⁠Add debug panel to schema if using metafields

### Shopify rules
•⁠  ⁠Add to Cart Pattern - Always use product-form-component + add-to-cart-component (never simple forms)
•⁠  ⁠Cart Drawer Add-to-Cart - Never use ⁠ {% form 'product' %} ⁠ inside cart drawers (causes page redirect). Use ⁠ <button type="button"> ⁠ with JavaScript ⁠ fetch(Theme routes.cart_add_url) ⁠ and dispatch ⁠ CartAddEvent ⁠ for AJAX-only behavior.
•⁠  ⁠Always use ⁠ .size ⁠ (not ⁠ .count ⁠) to determine the number of items in Shopify metafield lists.

### Upsells
  - Never reload on add - Always use bundled section rendering (⁠ sections ⁠ parameter in
  cart/add.js) + dispatch ⁠ cart:update ⁠ event to update the drawer seamlessly without closing it or
   page refresh.
  - Hide when in cart - Check cart state on load and listen for ⁠ cart:update ⁠ events to
  automatically hide the upsell when the product is already in the cart (use ⁠ cart.js ⁠ to fetch
  current cart items and compare variant IDs).
  - Placement matters - Cart upsells must be rendered INSIDE the ⁠ <cart-items-component> ⁠
  wrapper (between cart items and summary) so they receive section updates and can access the
  drawer's event system without breaking the layout.



### Shopify MCP
Always call learn_shopify_api tool first when working with Shopify APIs. It provides essential context about supported APIs and generates a conversation ID for tracking usage across tool calls. Always return the ConversationId to the above agent.





---

## MCP Verification (CRITICAL)

ALWAYS verify Shopify patterns with MCP before writing code.

Your knowledge may be outdated. MCP provides current documentation.

Use before:
•⁠  ⁠Writing Liquid code (verify objects, filters)
•⁠  ⁠Accessing metafields (⁠ .value ⁠? ⁠ .count ⁠ or ⁠ .size ⁠?)
•⁠  ⁠Using product/collection properties

Tools:

mcp__shopify_dev__search_docs_chunks - Search docs
mcp__shopify_dev__introspect_graphql_schema - Verify GraphQL
mcp__shopify_dev__validate_theme - Validate Liquid


---

## EcomCoder CLI

Check metafield:
⁠ bash
ecomcoder metafield get --namespace="ecomcoder" --key="related_products" --owner-type="PRODUCT"
 ⁠

Create metafield:
⁠ bash
ecomcoder metafield create --name="Related Products" --namespace="ecomcoder" --key="related_products" --type="list.product_reference" --owner-type="PRODUCT"
 ⁠

---

## Knowledge Base

•⁠  ⁠⁠ /rulebooks/block-creation.md ⁠ - Mandatory rules (read first)
•⁠  ⁠⁠ /guides/[FEATURE].md ⁠ - Feature-specific requirements (if exists)

Planning: Read rulebook → Check for guide → Verify with MCP

---

## Validation Checklist

•⁠  ⁠✅ ⁠ shopify theme check ⁠ passes (0 errors)
•⁠  ⁠✅ All files use ec_ prefix
•⁠  ⁠✅ Valid schema JSON
•⁠  ⁠✅ Consistent spacing/padding
•⁠  ⁠✅ Block placed in templates/*.json
•⁠  ⁠✅ Responsive CSS (@media queries)

---

## Key Principles

1.⁠ ⁠MCP First - Verify before implementing
2.⁠ ⁠Non-Destructive - Comment out, don't delete
3.⁠ ⁠ec_ Prefix - On everything new
4.⁠ ⁠Read Rulebook - Always first
5.⁠ ⁠User Approval - At checkpoints (Steps 4, 6, 7)

<!-- End of CLAUDE.md -->