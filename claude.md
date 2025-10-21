
Example General Workflow
User: "[Any feature request]"
You execute:

0. wait for the Orchestrator!

ASK THE USER the questions the orchestator gave you - give it the orchestrator back.

1. Trigger research-agent → Understand what the feature typically includes and best practices
2. Trigger location-subagent → Find where to implement (section file, supports blocks/inline, etc.)
3. Trigger query-docs-agent → find out what liquid and bestpractices you actually need for the implementation logic. (give him all the information he needs about the logic so he can search for this)

If multiple options: present to user and wait for selection

4. Trigger html-subagent (look what do provide this agent)→ Check if reusable snippets exist or need custom HTML (or even small parts of logic)
5. implement the complete request  → Create functional code BUT with placeholder CSS values (so you should NOT search for css- just use what is in your knowledge of a good design with every part)
6. Trigger css-subagent → Find theme-specific CSS values to replace placeholders (later)
7. Trigger specificity-agent → Determine correct CSS selector pattern to avoid overrides
8. Generate final code → Replace placeholders with theme values and correct specificity (now)
9. Implement code using Edit tools → Create/modify files in theme structure
10. Confirm to user → Report what was created/modified and any manual steps needed





THIS IS THE INPUT YOU GIVE THE AGENT


Html-subagents:
- you need to provide a list of all single components inside what we want to create and the entire thing itself. - Maybe he will find not the entire thing but a small part of what you need - maybe even only a similar logic (in this case you need to create the html youself but you can take it as inpiration (e.g the add to card logic))

css-subagent:
- provide a list of all css-styles your used inside the new component/section/block...
- the output of the ai will be a list of all css-styles you need to change





Notes:
for icons use lucide icons




--- if the request is just to edit something instead of creating something than your free to use the agents as you wish:

## Agent Reference Guide

### Orchestrator
**Purpose**: First contact agent that analyzes user requests and formulates clarifying questions
**When used**: Step 0 - Automatically triggered when user makes any feature request
**Output**: Questions for the user to clarify requirements before implementation begins

### research-agent
**Purpose**: Research best practices and typical implementations for requested features
**When used**: Step 1 - After Orchestrator questions are answered
**Output**: Understanding of what the feature typically includes and industry best practices

### location-subagent (Haiku)
**Purpose**: Determines where in the theme structure to implement the feature
**When used**: Step 2 - After research phase
**Checks**: /rulebooks for templates, then analyzes sections/blocks/snippets structure
**Output**: Recommended file location (section/block/snippet/template), file paths, and dependencies

### query-docs-agent
**Purpose**: Searches official Shopify documentation for Liquid syntax, objects, and APIs
**When used**: Step 3 - After location is determined
**Input needed**: Specific implementation logic details so it can search effectively
**Output**: Exact Liquid syntax, code examples, rules, and best practices from docs

### html-subagent (Haiku)
**Purpose**: Finds reusable snippets or similar HTML/Liquid patterns in the theme
**When used**: Step 4 - Before creating custom HTML
**Input needed**: List of all single components to search for (even small parts like "add to cart logic")
**Output**: Reusable snippets with file paths, existing patterns, or recommendation to create custom HTML

### css-subagent (Haiku)
**Purpose**: Finds theme-specific CSS values to replace placeholder styles
**When used**: Step 6 - After implementation with placeholder CSS
**Input needed**: List of all CSS styles used in the new component
**Workflow**: Searches parent section first, then base.css if needed
**Output**: List of CSS custom properties, color values, spacing scales, and naming conventions to use

### specificity-agent (Haiku)
**Purpose**: Determines correct CSS selector patterns to avoid style conflicts
**When used**: Step 7 - Before generating final CSS
**Output**: Recommended selector patterns, specificity levels, naming conventions, and potential conflicts to avoid