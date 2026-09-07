{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/editorialTeam.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the editorial team.
 *
 * @uses $currentContext Journal|Press The current journal or press
 *}
{include file="frontend/components/header.tpl" pageTitle="about.editorialTeam"}

<div class="max-w-xl-1200 mx-xl-auto main-content-layout">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.editorialTeam"}

	{include file="frontend/objects/text_layout.tpl" title={translate key="about.editorialTeam"}
	content=$currentContext->getLocalizedData('editorialTeam')}

	<div class="row mt-5">
		<div class="col-12 max-w-sm-900">
			{include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="masthead" sectionTitleKey="about.editorialTeam"}
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
