{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/announcements.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display a list of announcements
 *
 * @uses $announcements array List of announcements
 *}

{foreach from=$announcements item=announcement}
	{include file="frontend/objects/announcement_summary.tpl"}
{/foreach}
