{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/breadcrumbs_announcement.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display a breadcrumb nav item for announcements.
 *
 * @uses $currentTitle string The title to use for the current page.
 *
 *}

<div class="row mt-3">
	<div class="col-12">
		<nav role="navigation" aria-label="{translate key="navigation.breadcrumbLabel"}">
			<ol class="breadcrumb align-items-center">
				<li class="breadcrumb-item">
					<a href="{url page="index" router=$smarty.const.ROUTE_PAGE}"
						class="ammonite-breadcrumb-text text-decoration-none">
						{translate key="common.homepageNavigationLabel"}
					</a>
				</li>

				<li class="breadcrumb-item">
					<a href="{url page="announcement" router=$smarty.const.ROUTE_PAGE}"
						class="ammonite-breadcrumb-text text-decoration-none">
						{translate key="announcement.announcements"}
					</a>
				</li>

				<li class="breadcrumb-item active" aria-current="page">
					<span aria-current="page" class="text-black ammonite-breadcrumb-text">
						{$currentTitle|escape}
					</span>
				</li>
			</ol>
		</nav>
	</div>
</div>
