{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/breadcrumbs_article.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display a breadcrumb nav item showing the current page. This basic
 *  version is for top-level pages which only need to show the Home link. For
 *  category- and series-specific breadcrumb generation, see
 *  templates/frontend/components/breadcrumbs_catalog.tpl.
 *
 * @uses $currentTitle string The title to use for the current page.
 * @uses $currentTitleKey string Translation key for title of current page.
 * @uses $issue Issue Issue this article was published in.
 *}

<div class="row mx-0 mt-3">
	<div class="col-12 ps-0">
		<nav role="navigation" aria-label="{translate key="navigation.breadcrumbLabel"}">
			<ol class="breadcrumb align-items-center">
				<li class="breadcrumb-item">
					<a href="{url page="index" router=$smarty.const.ROUTE_PAGE}"
						class="ammonite-breadcrumb-text text-decoration-none">
						{translate key="common.homepageNavigationLabel"}
					</a>
				</li>
				<li class="breadcrumb-item">
					<a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}"
						class="ammonite-breadcrumb-text text-decoration-none">
						{translate key="navigation.archives"}
					</a>
				</li>
				{if $issue}
					<li class="breadcrumb-item">
						<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}"
							class="ammonite-breadcrumb-text text-decoration-none">
							{$issue->getIssueIdentification()|escape}
						</a>
					</li>
				{/if}
				<li class="breadcrumb-item active" aria-current="page">
					<span aria-current="page" class="ammonite-breadcrumb-text text-black">
						{if $currentTitleKey}
							{translate key=$currentTitleKey}
						{else}
							{$currentTitle|escape}
						{/if}
					</span>
				</li>
			</ol>
		</nav>
	</div>
</div>
