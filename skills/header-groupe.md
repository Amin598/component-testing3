
How it works:
  1. layout/theme.liquid contains {% sections 'header-group' %}
  2. This renders ALL sections defined in sections/header-group.json
  3. Sections appear in the order array sequence
  4. Displays on every page automatically

  Implementation Path

  Step 1: Create /sections/ec-name.liquid (name: what user wants exactly)
   - create in here: html / css / javascript / schema with needed settings


  Step 2: Add it to header-group.json: (example)
  {
    "sections": {
      "header_section": { ... },
      "promo_bar": {
        "type": "ec-name",
        "settings": {}
      }
    },
    "order": ["header_section", "promo_bar"]
  }

  Step 3: Merchants can customize via Theme Editor → Header section
  group


