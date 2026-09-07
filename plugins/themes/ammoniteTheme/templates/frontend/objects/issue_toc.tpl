{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/objects/issue_toc.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a full table of contents.
 *
 * @uses $issue Issue The issue
 * @uses $issueTitle string Title of the issue. May be empty
 * @uses $issueSeries string Vol/No/Year string for the issue
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $publishedSubmissions array Lists of articles published in this issue
 *   sorted by section.
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 * @uses $heading string HTML heading element, default: h2
 *}

{*  Issue introduction area above articles *}
{if !$labelAsCurrentIssue}
	{assign var=labelAsCurrentIssue value=false}
{/if}

{if !$calledByIndex}
	{assign var=calledByIndex value=false}
{/if}

{if !$calledByIssuePage}
	{assign var=calledByIssuePage value=false}
{/if}

{if !$issueIdentification}
	{assign var=issueIdentification value=false}
{/if}


<div class="ammonite-issue-content-section row mx-0 mx-xl-auto max-w-xl-1200 mt-3" style="background-color: rgba(235, 244, 246, 1);">
	<div class="row mx-0 mx-xl-auto max-w-xl-1200 py-4 main-content-layout px-tablet-0">
		{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
		{assign var=issueCoverAltText value=$issue->getLocalizedCoverImageAltText()}
		<div
			class="col-12 {if $calledByIndex and $issueCover}col-md-7{/if} ps-0 max-w-xl-1200 mx-xl-auto {if $issueCover}col-lg-8{/if}">
			{if $calledByIndex}
				<div class="row">
					<span class="ammonite-h1-text mb-3">
						{translate key="plugins.themes.ammonite.latestIssue"}
					</span>
				</div>

				<div class="row">
					<span class="ammonite-breadcrumb-text mb-4">
						{translate key="plugins.themes.ammonite.resumedVolume"} {$issue->getVolume()|escape} ({$issue->getYear()|escape})
						{if $issue->getNumber()}
							{translate key="issue.number"} {$issue->getNumber()|escape}
						{/if}
					</span>
				</div>

				<div class="row mb-1">
					<span class="ammonite-h3-text">
						{$issueTitle|escape}
					</span>
				</div>
			{else}
				<div class="row">
					<span class="ammonite-breadcrumb-text mb-3">
						{translate key="issue.vol"} {$issue->getVolume()|escape} ({$issue->getYear()|escape})
						{if $issue->getNumber()}
							{translate key="issue.number"} {$issue->getNumber()|escape}
						{/if}
					</span>
				</div>

				<div class="row">
					<h1 class="ammonite-h2-text">
						{$issueTitle|escape}
					</h1>
				</div>
			{/if}

			{*  Description *}
			{if $issue->hasDescription()}
				{$words = explode(' ', $issue->getLocalizedDescription()|strip_unsafe_html)}
				{$first_50_words = array_slice($words, 0, 50)}
				{$formatted_text = implode(' ', $first_50_words)}

				{if count($words) > 50}
					{$formatted_text = $formatted_text|cat:' [...]'}
				{/if}

				<div class="row mb-xl-5">
					<span class="ammonite-regular-text">
						{if $calledByIssuePage}
							{$issue->getLocalizedDescription()|strip_unsafe_html}
						{else}
							{$formatted_text}
						{/if}
					</span>
				</div>
			{/if}

			{if $issueGalleys && !$calledByIndex}
				{foreach from=$issueGalleys item=galley}
					<div class="row">
						{include file="frontend/objects/galley_link.tpl" parent=$issue labelledBy="issueTocGalleyLabel" purchaseFee=$currentJournal->getData('purchaseIssueFee') purchaseCurrency=$currentJournal->getData('currency')}
					</div>
				{/foreach}
			{/if}

			{if $calledByIndex}
				<div class="row d-none d-md-flex">
					<a href="{url page="issue" op="current"}"
						class="ammonite-regular-text text-decoration-none mb-2 d-flex align-items-center"
						style="font-weight: var(--font-weight-bold)!important;">
						{translate key="plugins.themes.ammonite.browseCurrentIssue"}
						<span class="ammonite-link-icon ms-2">></span>
					</a>
				</div>
			{/if}
		</div>

		<div class="col-12 {if $calledByIndex}col-md-5 d-sm-flex {else}d-lg-flex{/if} col-lg-4 px-0 justify-content-center justify-content-lg-end align-items-center issue-cover-image-section">
			<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}"
				class="d-flex justify-content-center justify-content-lg-end mx-5 mx-md-0">
				<img src="{$issueCover|escape}" alt="{$issueCoverAltText|escape|default:$defaultAltText}"
					class="ammonite-issue-img " id="issueCoverImage">
			</a>
		</div>
	</div>
</div>

{if !$calledByIndex}
	<div class="max-w-xl-1200 mx-xl-auto main-content-layout">
		{if !$issueIdentification}
			{include file="frontend/components/breadcrumbs_issue.tpl" currentTitleKey="current.noCurrentIssue"}
		{else}
			{include file="frontend/components/breadcrumbs_issue.tpl" currentTitle=$issueIdentification}
		{/if}

		{* Articles *}
		{foreach name=sections from=$publishedSubmissions item=section}
			{if $section.articles}
				{if $section.title}
					<div class="row pt-4">
						<div class="col-12">
							<h2 class="ammonite-h2-text mb-0">{$section.title|escape}</h2>
							<div class="ammonite-divider"></div>
						</div>
					</div>
				{/if}
				<div class="row mt-4 max-w-sm-900">
					{foreach from=$section.articles item=article}
						{include file="frontend/objects/article_summary.tpl" isFirstItem=$article@first}
					{/foreach}
				</div>
			{/if}
		{/foreach}

		<div class="my-4">
			<a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}"
				class="ammonite-secondary-button py-2 px-3 text-uppercase text-decoration-none text-center"
				style="font-weight: var(--font-weight-bold)!important;">
				{translate key="journal.viewAllIssues"}
			</a>
		</div>
	</div>
{/if}
