{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $hasAccess bool Can this user access galleys for this context? The
 *       context may be an issue or an article
 * @uses $showDatePublished bool Show the date this article was published?
 * @uses $hideCoverImage bool Hide the article galleys for this article?
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 * @uses $heading string HTML heading element, default: h2
 *}
{assign var=articlePath value=$article->getBestId()}

{if (!$section.hideAuthor && $article->hideAuthor == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->hideAuthor == $smarty.const.AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

{if !$hideCoverImage}
	{assign var="hideCoverImage" value=false}
{/if}

{if !$comesFromSearch}
	{assign var="comesFromSearch" value=false}
{/if}

{assign var=publication value=$article->getCurrentPublication()}
{assign var="coverImage" value=$publication->getLocalizedData('coverImage')}

<div class="col-12 mb-xl-5">
	<a class="text-decoration-none"
		{if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}" {else}href="
			{url page="article" op="view" path=$articlePath}" {/if}>

		<div class="row {if $comesFromSearch}mb-5{/if}">
			{if !$hideCoverImage and (!!$coverImage or !!$defaultArticleImage)}
			<div class="col-12 col-md-4 {if !$isFirstItem}mt-3{/if}">
					<img
						src="{if !!$coverImage}
								{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}
							{else}
								{$defaultArticleImage|escape}
							{/if}"
						alt="{if !!$coverImage}{$coverImage.altText|escape|default:''}{else}{translate key="plugins.themes.ammonite.noArticleCoverImageAltText"}{/if}"
						class="ammonite-article-summary-img"
					>
				</div>
			{else}
				<div class="col-12 col-sm-4"></div>
			{/if}


			{if !is_null($article->firstSubcategory)}
				<div class="col-12 mx-0 mt-3 mb-2 d-flex d-sm-none">
					<span class="ammonite-breadcrumb-text px-0">
						{$article->firstSubcategory->getLocalizedData('title')|escape}
					</span>
				</div>
			{/if}

			<div class="col-12 mt-xl-0 {if !$hideCoverImage}col-md-8 mt-sm-2 mb-4{/if}">
				{* Authors *}
				{if $showAuthor && $comesFromSearch}
					<div class="row pl-2">
						<span class="ammonite-breadcrumb-text">
							{$publication->getAuthorString($authorUserGroups)|escape}
						</span>
					</div>
				{/if}


				{if !is_null($article->firstSubcategory)}
					<div class="row mb-2 mx-0 d-none d-sm-flex">
						<span class="ammonite-breadcrumb-text px-0">
							{$article->firstSubcategory->getLocalizedData('title')|escape}
						</span>
					</div>
				{/if}

				<div class="row mb-2 mb-xl-3 pl-2">
					<span class="ammonite-regular-text mb-0 fw-bold" style="line-height: 1.2!important;">
						{$publication->getLocalizedData('title')|strip_unsafe_html}
					</span>
				</div>

				{* Authors *}
				{if $showAuthor && !$comesFromSearch}
					<div class="row pl-2">
						<span class="ammonite-breadcrumb-text">
							{$publication->getAuthorString($authorUserGroups)|escape}
						</span>
					</div>
				{/if}

				<div class="row pl-2">
					<span class="ammonite-breadcrumb-text">
						{$publication->datePublished|date_format:$dateFormatLong}
					</span>
				</div>
			</div>
		</div>
	</a>
</div>
