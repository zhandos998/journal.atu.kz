{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/navigationMenuItemViewContent.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display NavigationMenuItem custom page content
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$title}

<div class="max-w-xl-1200 mx-xl-auto main-content-layout">
	{include file="frontend/components/breadcrumbs.tpl" currentTitle={$title|escape}}

	{include file="frontend/objects/text_layout.tpl" title={$title|escape} content=$content}
</div>

{include file="frontend/components/footer.tpl"}
