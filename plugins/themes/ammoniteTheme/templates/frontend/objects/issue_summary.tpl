{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a summary for use in lists. Must be contained within a .row class.
 *
 * @uses $issue Issue The issue
 *}
{if $issue->getShowTitle()}
	{assign var=issueTitle value=$issue->getLocalizedTitle()}
{/if}
{assign var=issueSeries value=$issue->getIssueSeries()}
{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}

<div class="col-6 col-sm-4 col-xl-2 mb-5 me-xl-2">
	<a href="{url op="view" path=$issue->getBestIssueId()}" class="text-decoration-none">
		<div class="row mb-4 mx-0">
			<img src="{if !!$issueCover}{$issueCover|escape}{elseif $defaultIssueCoverImg}{$defaultIssueCoverImg|escape}{/if}"
				alt="{if !!$issueCover}{$issue->getLocalizedCoverImageAltText()|escape|default:''}{else}{translate key="plugins.themes.ammonite.noIssueCoverImageAltText"}{/if}"
				class="ammonite-issue-cover-img px-0">
		</div>

		<div class="row mb-4">
			<span class="ammonite-breadcrumb-text" style="max-width: 180px!important;">
				{translate key="issue.vol"} {$issue->getVolume()|escape} ({$issue->getYear()|escape})
				{if $issue->getNumber()}
					{translate key="issue.number"} {$issue->getNumber()|escape}
				{/if}
			</span>
		</div>

		<div class="row">
			<span class="ammonite-breadcrumb-text pe-0" style="max-width: 180px!important;">
				{$issueTitle|escape}
			</span>
		</div>
	</a>
</div>
