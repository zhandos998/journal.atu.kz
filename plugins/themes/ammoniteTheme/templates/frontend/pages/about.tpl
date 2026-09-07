{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/about.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view a journal's description, contact details,
 *  policies and more.
 *
 * @uses $currentContext Journal|Press The current journal or press
 *}
{include file="frontend/components/header.tpl" pageTitle="about.aboutContext"}


<div class="max-w-xl-1200 mx-xl-auto main-content-layout">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.aboutContext"}

	{include file="frontend/objects/text_layout.tpl" title={translate key="about.aboutContext"}
	content=$currentContext->getLocalizedData('about')}

	<div class="row mt-5">
		<div class="col-12 max-w-sm-900">
			{include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="masthead" sectionTitleKey="about.aboutContext"}
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
