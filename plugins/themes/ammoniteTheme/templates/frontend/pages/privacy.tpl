{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/privacy.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the privacy policy.
 *
 * @uses $currentContext Journal|Press The current journal or press
 *}
{include file="frontend/components/header.tpl" pageTitle="manager.setup.privacyStatement"}

<div class="max-w-xl-1200 mx-xl-auto main-content-layout">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="manager.setup.privacyStatement"}

	{include file="frontend/objects/text_layout.tpl" title={translate key="manager.setup.privacyStatement"}
	content=$privacyStatement}
</div>

{include file="frontend/components/footer.tpl"}
