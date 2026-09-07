{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/aboutThisPublishingSystem.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view details about the OJS software.
 *
 * @uses $currentContext Journal The journal currently being viewed
 * @uses $appVersion string Current version of OJS
 * @uses $contactUrl string URL to the journal's contact page
 *}
{include file="frontend/components/header.tpl" pageTitle="about.aboutSoftware"}

<div class="max-w-xl-1200 mx-xl-auto main-content-layout">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.aboutSoftware"}

	{capture assign="content"}
		{if $currentContext}
			{translate key="about.aboutOJSJournal" ojsVersion=$appVersion contactUrl=$contactUrl}
		{else}
			{translate key="about.aboutOJSSite" ojsVersion=$appVersion}
		{/if}
	{/capture}

	{include file="frontend/objects/text_layout.tpl" title={translate key="about.aboutSoftware"} content={$content}}
</div>

{include file="frontend/components/footer.tpl"}
