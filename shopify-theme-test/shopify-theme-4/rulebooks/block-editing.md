# Block Editing Guide

Step-by-step guide for editing existing blocks.

---

## Step 1: Identify Theme Version

Check if `/blocks` folder exists:

- Has `/blocks` folder = New Shopify 2.0+ theme
- No `/blocks` folder = Old Shopify theme

---

## Step 2: Find the Block and read/understand it

### New Theme (has /blocks folder)
Block files: `blocks/block-name.liquid`

### Old Theme (no /blocks folder)
1. Find section file: `sections/main-product.liquid`
2. Blocks defined inside section's `{% schema %}`
3. Rendering in section file: `{%- when 'block-type' -%}`
4. May use snippets: `{%- render 'snippet-name' -%}`
5. If snippet avaible than check snippet too: snippets/snippet.name.liquid

---

## Step 3: Identify Block Type

### EcomCoder Blocks
Prefix: `ec-*` or `ec_*`

If editing our block: Read `rulebooks/block-creation.md` first. To get a better understand of its build.

---

## Step 4: Understand the Block

Use one subagent to understand THIS block only:
- Where is it located?
- What does it do?
- What settings exist?
- Uses metafields?
- HTML structure?
- CSS classes?

Don't explore entire codebase here again.

---

## Step 5: Check Guides

Look in `/guides` folder for this feature type.

- Guide exists → check if something in there fits to the users requirments and take it as help
- No guide → Research typical patterns with subagent
- Still unclear → Ask user for clarification

Compare guide/research to actual block in codebase.

---

## Step 6: Think Before Changing

What does user actually want?
- Layout change or styling change?
- Add new or modify existing?
- do you need to rearrange
- do you really need to make something bigger or smaller? (change size especially for images only when 100% clear you need to change it -  for the most rearranges doesnt need to change the site)
- Simplest solution?

Don't over-engineer.

---

## Common Mistakes

### Wrong: Changing sizes when rearranging

for example
User: "Make grid horizontal scrollable"
Don't change img / coloum sizes unless it really doent fit:


### Wrong: Using .size instead of .count

```liquid
{%- if products.value.size > 0 -%}  <!-- WRONG -->
{%- if products.value.count > 0 -%}  <!-- CORRECT -->
```

### Wrong: Deleting code

Comment instead:
```liquid
{% comment %} Old code:
<div>old</div>
{% endcomment %}
<div>new</div>
```

### Wrong: Changing setting IDs

Never change `"id"` in schema - breaks configurations.

---

## MCP Verification

Before changing Liquid code using Shopify objects:

Use: `mcp__shopify-dev__search_docs_chunks`
Verify: correct access patterns

---

### Wrong:
- forgetting to make a phone sized responsivness and break version
    - always think about a change if this change looks on desktop as good as on phones (without scrollablity to the x-direction: If desktop version is scrollable than phone version should not too)
    - blocks should be in all ways responsive. even divs inside the block should be responsive (if two divs are inside one row than when shrinking the side - it should shrink with until it hits  point where the right div get moved down and both get big again.)


## Validation

1. Run `shopify theme check`
2. Run MCP `validate_theme`
3. Test in theme customizer
4. Test mobile/tablet/desktop
5. Check browser console

---

Keep changes simple. Understand user needs first.
