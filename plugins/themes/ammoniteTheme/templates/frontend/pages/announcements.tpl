{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/announcements.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the latest announcements
 *
 * @uses $announcements array List of announcements
 *}
{include file="frontend/components/header.tpl" pageTitle="announcement.announcements"}

<div class="max-w-xl-1200 mx-xl-auto main-content-layout">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="announcement.announcements"}

	<div class="row mt-4">
		<div class="col-12 max-w-sm-900">
			<h1 class="ammonite-h1-text">
				{translate key="plugins.themes.ammonite.journalNews"}
			</h1>
		</div>
	</div>

	<div class="row mt-4">
		<div class="col-12 max-w-sm-900">
			<span class="ammonite-regular-text ammonite-announcements-description">
				{$announcementsIntroduction|strip_unsafe_html}
			</span>
		</div>
	</div>

	<div>
		{include file="frontend/components/announcements.tpl"}
	</div>
</div>

{include file="frontend/components/footer.tpl"}
