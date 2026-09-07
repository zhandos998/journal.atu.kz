{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/pagination.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common template for displaying pagination
 *
 * @uses $prevUrl string URL to the previous page
 * @uses $nextUrl string URL to the next page
 * @uses $firstPageUrl string URL to the first page
 * @uses $lastPageUrl string URL to the last page
 * @uses $showingStart int The number of the first item shown on this page
 * @uses $showingEnd int The number of the last item shown on this page
 * @uses $total int The total number of items available
 * @uses $currentPage int The number of the current page
 * @uses $nextPage int The number of the next page if current isn't the last
 * @uses $lastPage int The number of the last page
 *}

{if $prevUrl || $nextUrl}
	<div class="row mb-5" aria-label="{translate|escape key="common.pagination.label"}">
		<div class="col-12 d-flex justify-content-center">
			{if $prevUrl}
				<a class="text-decoration-none" href="{$firstPageUrl}">
					<span class="visually-hidden">{translate key="plugins.themes.ammonite.firstPage"}</span>
					<i class="fas fa fa-chevron-left" aria-hidden="true"></i>
					<i class="fas fa fa-chevron-left" style="margin-left: -1rem;" aria-hidden="true"></i>
				</a>
			{/if}

			{if $prevUrl}
				<a class="text-decoration-none ms-3" href="{$prevUrl}">
					<span class="visually-hidden">{translate key="plugins.themes.ammonite.previousPage"}</span>
					<i class="fas fa fa-chevron-left" aria-hidden="true"></i>
				</a>
			{/if}

			<div class="d-flex align-items-center">
				<span class="ammonite-breadcrumb-text ms-3"
					{if $currentPage == 1}style="font-weight: var(--font-weight-bold);" {/if}>1</span>

				{if $currentPage-1 > 2}
					<span class="ammonite-breadcrumb-text ms-3">...</span>
				{/if}

				{if $prevUrl && $currentPage-1 > 1}
					<span class="ammonite-breadcrumb-text ms-3">{$currentPage-1}</span>
				{/if}

				{if $currentPage != 1}
					<span class="ammonite-breadcrumb-text ms-3"
						style="font-weight: var(--font-weight-bold);">{$currentPage}</span>
				{/if}

				{if $currentPage == 1 && $currentPage+1 < $lastPage}
					<span class="ammonite-breadcrumb-text ms-3">{$currentPage+1}</span>
				{/if}

				{if $currentPage+2 <= $lastPage}
					<span class="ammonite-breadcrumb-text ms-3">...</span>
				{/if}

				{if $nextUrl}
					<span class="ammonite-breadcrumb-text mx-3">{$lastPage}</span>
				{/if}
			</div>

			{if $nextUrl}
				<a class="text-decoration-none me-3" href="{$nextUrl}">
					<span class="visually-hidden">{translate key="plugins.themes.ammonite.nextPage"}</span>
					<i class="fas fa fa-chevron-right" aria-hidden="true"></i>
				</a>
			{/if}

			{if $nextUrl}
				<a class="text-decoration-none" href="{$lastPageUrl}">
					<span class="visually-hidden">{translate key="plugins.themes.ammonite.lastPage"}</span>
					<i class="fas fa fa-chevron-right" aria-hidden="true"></i>
					<i class="fas fa fa-chevron-right" style="margin-left: -1rem;" aria-hidden="true"></i>
				</a>
			{/if}
		</div>
	</div>
{/if}
