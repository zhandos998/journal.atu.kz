{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/search.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to search and view search results.
 *
 * @uses $query Value of the primary search query
 * @uses $authors Value of the authors search filter
 * @uses $dateFrom Value of the date from search filter (published after).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $dateTo Value of the date to search filter (published before).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $yearStart Earliest year that can be used in from/to filters
 * @uses $yearEnd Latest year that can be used in from/to filters
 *}
{include file="frontend/components/header.tpl" pageTitle="common.search"}

<div class="max-w-xl-1200 main-content-layout mx-xl-auto">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="common.search"}

	<div class="row mt-4">
		<div class="col-12 col-xl-6">
			<h1 class="ammonite-h1-text">
				{translate key="common.search"}
			</h1>

			<div class="row mx-0">
				<span class="ammonite-regular-text px-0">
					{translate key="plugins.themes.ammonite.searchInformation"}
				</span>
			</div>

			{capture name="searchFormUrl"}{url escape=false}{/capture}
			{assign var=formUrlParameters value=[]}{* Prevent Smarty warning *}
			{$smarty.capture.searchFormUrl|parse_url:$smarty.const.PHP_URL_QUERY|parse_str:$formUrlParameters}

			<form id="search" method="get" action="{$smarty.capture.searchFormUrl|strtok:"?"|escape}">
				{foreach from=$formUrlParameters key=paramKey item=paramValue}
					<input type="hidden" name="{$paramKey|escape}" value="{$paramValue|escape}" />
				{/foreach}

				<div class="row">
					<div class="col-12">
						<span class="visually-hidden" for="query">{translate key="search.searchFor"}</span>

						<label for="query"
							class="form-label ammonite-label-text">{translate key="common.searchQuery"}</label>

						{block name=searchQuery}
							<div class="input-group input-group-lg">
								<input type="text" id="query" name="query" value="{$query|escape}"
									class="form-control ammonite-underlined-input" />
							</div>
						{/block}
					</div>
				</div>

				{* Filter Authors *}
				<div class="row mt-4">
					<div class="col-12">
						<label class="form-label ammonite-label-text"
							for="authors">{translate key="search.author"}</label>

						{block name=searchAuthors}
							<div class="input-group input-group-lg">
								<input type="text" name="authors" id="authors" value="{$authors|escape}"
									class="form-control ammonite-underlined-input" />
							</div>
						{/block}
					</div>
				</div>

				{* Advanced search *}
				<fieldset form="search">
					<legend class="visually-hidden">{translate key="common.search"}</legend>
					<div id="advancedSearchForm">
						<div class="row mt-4">
							<div class="col-12">
								<span class="ammonite-label-text">{translate key="search.dateFrom"}</span>
							</div>
						</div>

						<div class="row mt-3">
							<div class="col-12">
								<div class="custom-date-selects">
									{html_select_date prefix="dateFrom" time=$dateFrom start_year=$yearStart end_year=$yearEnd year_empty="Year" month_empty="Month" day_empty="Day" field_order="YMD"}
								</div>
							</div>
						</div>

						<div class="row mt-4">
							<div class="col-12">
								<span class="ammonite-label-text">{translate key="search.dateTo"}</span>
							</div>
						</div>

						<div class="row mt-3">
							<div class="col-12">
								<div class="custom-date-selects">
									{html_select_date prefix="dateTo" time=$dateTo start_year=$yearStart end_year=$yearEnd year_empty="Year" month_empty="Month" day_empty="Day" field_order="YMD"}
								</div>
							</div>
						</div>

						{call_hook name="Templates::Search::SearchResults::AdditionalFilters"}
					</div>
				</fieldset>

				<div class="row mt-3">
					<div class="col-12 mt-3">
						<button id="ammonite-search-button" type="submit"
							class="ammonite-primary-button px-5 py-2 w-100">
							{translate key="common.search"}
						</button>
					</div>
				</div>
			</form>
			{call_hook name="Templates::Search::SearchResults::PreResults"}
		</div>

		{assign var=userFilledAnyField value=false}
		{if $query != '' || $authors != '' || $dateFrom != '' || $dateTo != ''}
			{assign var=userFilledAnyField value=true}
		{/if}

		<div class="col-12 col-xl-6 mt-5 mt-xl-0">
			{if $userFilledAnyField}
				<div class="row">
					<div class="col-12">
						<h2 class="ammonite-h2-text">
							{translate key="plugins.themes.ammonite.search.resultsFor" query=$query|escape}
						</h2>
					</div>
				</div>
			{/if}

			{* Search results, finally! *}
			<div class="row mt-4">
				<div class="col-12">
					{iterate from=results item=result}
					{include file="frontend/objects/article_summary.tpl" headingLevel="h1" article=$result.publishedSubmission journal=$result.journal showDatePublished=true hideCoverImage=true hideAbstract=true comesFromSearch=true}
					{/iterate}
				</div>
			</div>

			{* Results pagination *}
			{if !$results->wasEmpty()}
				{assign var="count" value=$results->count}
				<div class="visually-hidden" role="status">
					{if $results->count > 1}
						{translate key="search.searchResults.foundPlural" count=$results->count}
					{else}
						{translate key="search.searchResults.foundSingle"}
					{/if}
				</div>
			{/if}

			<div class="d-flex align-items-center justify-content-between ammonite-search-pagination ml-4">
				{if $userFilledAnyField}
					{* No results found *}
					{if $results->wasEmpty()}
						{if $error}
							{include file="frontend/components/notification.tpl" type="error" message=$error|escape}
						{else}
							{include file="frontend/components/notification.tpl" type="secondary" messageKey="search.noResults"}
						{/if}
					{else}
						{page_info iterator=$results}
						{page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear}
					{/if}
				{/if}
			</div>
		</div>
	</div>
</div>


{include file="frontend/components/footer.tpl"}
