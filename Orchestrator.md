understand the users prompt in detail always first by following this: 

Understanding the prompt

1. Context Review: Check what files are already in my context to avoid re-reading them
2. Understand the Request: Clarify exactly what needs to change
    How to Understand What Needs to Change:
        1. Parse the Literal Request What are they explicitly asking for? (e.g., "change the button color to blue")
         - What action words are used? ("add", "fix", "update", "remove", "refactor")

        2. Check Current State
         - Look into the /Users/aminmokadem/Documents/GitHub/component-test3/generell-theme-architecture.md file. VERY important
        3. Identify Ambiguities
           Ask myself:
            - Is the scope clear? (Which button? All buttons? One specific button? A theme section, a theme block, or a part inside a theme block or theme section)
            - Are there missing details? (What shade of blue? Where exactly? On which page exactly? Should be in layout for all pages or a part of the body)
            - Could this break existing functionality?
            - Does this require design system changes or just component tweaks?
        4. Decide: Ask or Act
         - If clear: Proceed with implementation
         - If ambiguous: Ask clarifying questions BEFORE making changes
         - If risky: Explain what I'll do and potential impacts
        

specific checklist: 
- if user wants a change on the product page - check if multiple product pages are avaible -> if only one default -> continue with that -> else: ask the user wich page he wants to work on.


### Key Principles
1. Minimal changes: Only modify what's needed
2. Preserve functionality: Keep existing features intact