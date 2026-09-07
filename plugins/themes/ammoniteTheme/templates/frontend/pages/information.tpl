{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/information.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Information page.
 *
 *}
{if !$contentOnly}
	{include file="frontend/components/header.tpl" pageTitle=$pageTitle}
{/if}

<div class="max-w-xl-1200 mx-xl-auto main-content-layout">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey=$pageTitle}

	{include file="frontend/objects/text_layout.tpl" title={translate key={$pageTitle}} content=$content}

	<div class="row mx-0 mt-5 px-4">
		<div class="col-12 max-w-sm-900">
			{include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="setup/information" sectionTitleKey="manager.website.information"}
		</div>
	</div>
</div>

{if !$contentOnly}
	{include file="frontend/components/footer.tpl"}
{/if}
