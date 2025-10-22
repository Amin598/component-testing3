This is a step by step guide to implement the feature you need as a component-block for a section

## Core Philosophy

1. Checkout the mandatory structure on how to create a block (below)
2. If there is a dedicated guide for this feature in the /guides directory, follow it closely. If not, use a subagent to research what the feature should include (best practice) and how it should be structured before proceeding.
3. Plan the feature in detail and return the standard feature output for this feature


## MANDATORY: MCP Verification Before Writing Liquid Code

Before writing ANY Liquid code that uses Shopify objects (metafields, products, collections, etc.):

1. Use mcp__shopify-dev__search_docs_chunks to search for the EXACT object/type you're using
2. Read how to access it in Liquid (e.g., .value, .count vs .size, etc.)
3. Verify reference vs non-reference types and their access patterns
4. THEN write the code

Example: For list.product_reference metafields:
- Use .value to get the array
- Use .count (NOT .size) to check length
- Iterate directly over .value

Never assume - always verify with MCP docs first.


---------------------------------------------------------------------------------
Mandatory Structure for Blocks
---------------------------------------------------------------------------------


PREPERATION: If a theme has the folder /Blocks we know that it is a new Theme from Shopify 2.0+ else we know it is an old theme Shopify 2.0. Use one of the two Setups depending on wether this is a new or an old theme

---------------------------------------------------------------------------------

SETUP: NEW SHOPIFY THEME

If you see the theme has a /blocks folder (shopify 2.0+):

Add a single file with the name blocks/ec-name.liquid (name= the component you want to add e.g. trustbadges)

This file should include:
1. liquid logic - Get product, metafield data, settings (if needed)
2. html and logic of the block. If the created block uses metafields consider following step (it makes the block visibal for the user when no product are added, and gives the user right to toggle the block off/on himself)
  
    add this at the end

        (html rest above)

          {%- else -%}
            {%- if block.settings.show_block -%} (this is for the new setting in the schema)
            <div class="ec-related-block" style="background: #f5f5f5; border-color: #ddd; padding: 2rem; text-align: center;" {{ block.shopify_attributes }}>
              <p style="margin: 0 0 0.5rem 0; color: #666; font-size: 1rem; font-weight: 600;">
                    No products added to the metafield yet
              </p>
              <p style="margin: 0; color: #999; font-size: 0.875rem; line-height: 1.4;">
                   Toggle off in settings in theme customizer to hide this block. Added products will always display here automatically
              </p>
            </div>
              {%- endif -%}   (this ends the if statement for the new setting in the schema)
            {%- endif -%}
    
    lastly, add this to the schema settings of this block (this should be the first setting - it allows the user to hide/show the complete block)
      {
          "type": "checkbox",
          "id": "show_block",
          "label": "Display related products block",
          "info": "Toggle on/off to show or hide this block completely",
          "default": true                      (default always needs to be true)
        },

3. add css styles below html (use {%- stylesheet -%} tags) and responsiveness of the block (also think of gereral phone and tablet responsivness, sometimes css needs alignments for parts because without it parts will float around)
4. add javascript below css - Interactivity or dynamic content (optional, use </script>)
5. add schema below javascript (if no js than below html) for block with setting for “shopify theme customizer” (add settings if necessary)
5. pay attention to the correct use of the shopify 2.0+ conventions while implementing




SETUP: OLD SHOPIFY THEME

1. first find out where the section is under “/section” which the user wants to change or add. e.g. main-product.liquid (you can always search for components which are near them -> for main-product.liquid is it e.g. the buy button)
2. In this file there is a schema like this: {%schema%} 
3. Add in there the schema for blocks with setting for “shopify theme customizer” (add settings if necessary)
4. Create a reference in the same file for html and css 

    {%- when 'xy' -%}
    {%- render 'xy.liquid', block: block, … -%}

5. create a file ec-name.liquid in snippets and add  html. If the created block uses metafields consider following step (it makes the block visibal for the user when no product are added, and gives the user right to toggle the block off/on himself)

     add this at the end

        (html rest above)

          {%- else -%}
            {%- if block.settings.show_block -%} (this is for the new setting in the schema)
            <div class="ec-related-block" style="background: #f5f5f5; border-color: #ddd; padding: 2rem; text-align: center;" {{ block.shopify_attributes }}>
              <p style="margin: 0 0 0.5rem 0; color: #666; font-size: 1rem; font-weight: 600;">
                    No products added to the metafield yet
              </p>
              <p style="margin: 0; color: #999; font-size: 0.875rem; line-height: 1.4;">
                   Toggle off in settings in theme customizer to hide this block. Added products will always display here automatically
              </p>
            </div>
              {%- endif -%}   (this ends the if statement for the new setting in the schema)
            {%- endif -%}
    
    lastly, add this to the schema settings of this block (this should be the first setting - it allows the user to hide/show the complete block)
      {
          "type": "checkbox",
          "id": "show_block",
          "label": "Display related products block",
          "info": "Toggle on/off to show or hide this block completely",
          "default": true                      (default always needs to be true)
        },

6 above the html add the css styles in "<style></style>" Tags (also think off general phone and tablet responsivness, sometimes css needs alignments for parts - without it parts will float around)
7. pay attention to the correct use of the shopify 2.0 conventions while implementing

---------------------------------------------------------------------------------------------

Last step (for both new and old themes):
Goal: Make the created block visible by adding it at the appropriate position! So that the user will immediatly see it.


File to Edit: templates/XY.json
Add the Block after the the component where the user wants it to be. If unclear add it to the Unclear list.

          "name_aB3dEf": {  (this is just an example name)
            "type": "name",
            "settings": {
              }
             },


Add the block, which we just named above (e.g. name_aB3dEf), inside the block_order keep the name constant to the name above (e.g name_aB3dEf):

Example:
          "block_order": [
            "product_title_GnyQiN",
            "reviews",
            "price_a7krng",
            "variant_picker_R3rGDr",
            "name_aB3dEf",   (the name needs to be identical)
            "buy_buttons_eYQEYi",
            "product_description_LfDYCg",
            "group_X39hBc",
            "accordion_g8EVVp",
            "ec_related_product_xFXyJt"
          ]

---------------------------------------------------------------------------------------------------

Common pitfalls:
- the schema name may max 25 characters
- if the block includes images in anyway (e.g. assets or product images) than check first which ratio they use already. These are the most commen sizes which you should also use for:
  - portrait 4:5 ratio 
  - square 1:1 ratio  
- dont make the images bigger unless the customer want so - if you rearrange somethings than you always need to check if a resize a needed

### Wrong:
- forgetting to make a phone sized responsivness and break version
    - always think about a change if this change looks on desktop as good as on phones (without scrollablity to the x-direction: If desktop version is scrollable than phone version should not too)
    - blocks should be in all ways responsive. even divs inside the block should be responsive (if two divs are inside one row than when shrinking the side - it should shrink with until it hits  point where the right div get moved down and both get big again.)

---------------------------------------------------------------------------------
standard feature output:
---------------------------------------------------------------------------------

Unclear:
1. We found metafield xy that we could use. Do you want to use it or create a new one?
2. Unclear point 2
3. Unclear point N


Feature XY:

Phase 1: Analysis
Use parallel subagents to explore existing code if they are not already in you context, Check if metafields needed, Identify files to modify, Note dependencies on other features
//WRITE ACTUAL TODOS FOR FEATURE HERE//

Phase 2: Data Setup (only if needed)
Create metafields or ask user if we should use XY (an already existant metafield).
//WRITE ACTUAL TODOS FOR FEATURE HERE//

Phase 3: Implementation
FIRST: Use MCP tools to verify Shopify API usage patterns
- mcp__shopify-dev__search_docs_chunks for any Liquid objects/filters
- mcp__shopify-dev__introspect_graphql_schema for GraphQL queries
- If the block uses metafields, add a toggleable debug panel in the schema. When enabled, show a message if required metafields are missing, with instructions to set them. Allow hiding the panel via the editor.
//WRITE ACTUAL TODOS FOR FEATURE HERE//

Phase 4: Validate and test
Todo 1: Check all elements for consistent padding, margin, and spacing to ensure the layout looks balanced, clean, and visually welcoming 
Todo 2: Run `shopify theme check`
Todo 3: Run MCP `validate_theme`

Phase 5: Iterate and Validate untill no more errors

---------------------------------------------------------------------------------
standard feature output end:
---------------------------------------------------------------------------------
