# Ammonite Theme

An OJS theme designed by the Geological Survey of Denmark and Greenland and contributed to the OJS community.

## Requirements

This is a **child theme** of the [Health Sciences theme](https://github.com/pkp/healthSciences).
The parent Health Sciences theme **must be installed and present** in the OJS
plugin registry; otherwise this theme will refuse to register its styles,
templates and hooks and an admin notice will be shown on the Website Settings
page.

Install order:

1. Install and verify the Health Sciences theme.
2. Install this theme.
3. Activate "Ammonite Theme" under *Settings → Website → Appearance → Theme*.

Compatible with OJS 3.5.0-x

---

## Theme Options

All options are configured in the OJS admin panel under **Website → Appearance → Theme**. After saving, you may need to clear your browser cache and the OJS template cache for changes to take effect.

### 1. Primary Colour (inherited from parent theme)

The selected hex colour is injected into LESS as `@primary-colour` and drives the dominant accent colour across the theme (header, links, buttons, highlights). The theme automatically calculates an accessible text colour to render on top of this colour (`@text-on-primary-colour`) and a hover background colour for the primary menu (`@colour-on-primary-menu-hover`), using a WCAG contrast routine. If invalid or empty, the theme falls back to `#1E6292`.

### 2. Colour for Journal News section background

Sets the LESS variable `@colour-news-section`, used as the background of the "Journal News" block on the homepage. A matching accessible text colour is computed automatically. Invalid values revert to the default `#000000`.

### 3. Colour for Information section background

Sets the LESS variable `@colour-info-section`, used as the background of the "Information" block on the homepage (which sits alongside the Authors / Librarians blocks). A matching accessible text colour (`@colour-on-info-section`) is computed automatically. Invalid values revert to the default `#d2dae4`.

### 4. Homepage Information block title

Rendered as the heading of the homepage Information block. Type a short title (e.g. "About this Journal"). Leave blank to hide the heading.

### 5. Homepage Information block content

Rendered as the body of the homepage Information block, alongside the standard "For Authors" / "For Librarians" panels. Use the rich-text editor to enter formatted text, links, lists, etc.

### 6. Homepage articles (per category)

Controls how many of the most recent published articles are displayed under each category listed on the homepage (see option 7). Enter a positive integer. Higher values increase homepage length.

### 7. Categories to show Articles on Homepage

For each selected category, the homepage renders a section listing the latest articles assigned to that category. The order in which categories are dragged in this list is the order they appear on the homepage. Categories with no published articles are silently skipped. Tick the parent categories you want featured on the homepage and drag to reorder.

### 8. Featured subcategories (as list)

Pick one parent category; the theme renders its subcategories as a flat list section on the homepage. Leave as **None** to hide this section.

### 9. Category to show first child on article

When rendering article cards (catalog category page, issue page) and submission listings on the homepage, the theme looks at the article's assigned categories and displays the **first subcategory** that descends from this chosen parent category. Useful when a journal uses a tagging-style parent category (e.g. "Topics") and wants the topic chip shown on each article tile. Leave as **None** to disable.

### 10. Default Image for Cover Issue

Used as the fallback cover image whenever an issue has no cover of its own. The dropdown is populated from files uploaded to the journal's Publisher Library. Upload an image to **Settings → Workflow → Publisher Library** first with the "Others" category, then select it here.

### 11. Default Image for Article

Used as the fallback thumbnail/illustration for articles that don't have their own image. Sourced from the Publisher Library. Upload an image to the Publisher Library, then select it from the dropdown.

### 12. Logo for footer

Renders an additional logo immediately above the OJS brand logo in the footer. Upload your organisation logo to the Publisher Library, then select it here.

### 13. Alt text for footer logo

Provides the `alt` attribute for the footer logo image (option 12). Important for accessibility and screen readers.

### 14. Footer logo link

Wraps the footer logo in an anchor pointing to this URL. Enter the full URL (including `https://`) where clicking the footer logo should send users. Leave blank to render the logo without a link.

### 15. Article metadata to show

Controls which metadata blocks render on the article landing page. The selected values are passed to the article template, which conditionally renders each section. Available options:
  - `supportingAgencies` – Funding / supporting agencies
  - `categories` – Categories assigned to the article
  - `section` – Journal section
  - `subjects` – Subjects
  - `disciplines` – Disciplines
  - `coverage` – Coverage
  - `rights` – Rights
  - `source` – Source
  - `type` – Type

Tick every metadata block you want visible on the article page. Unchecked items are hidden even if data exists.

---

## Troubleshooting

- **A colour change is not visible** — clear the OJS template cache and your browser cache.
- **A category does not appear on the homepage** — confirm it has at least one published article assigned; categories with no published submissions are skipped automatically.
- **A library image dropdown is empty** — upload the file in the Publisher Library and reload the customize page.
