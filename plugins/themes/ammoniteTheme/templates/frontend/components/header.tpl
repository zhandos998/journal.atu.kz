{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *}

<!doctype html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
<body>
{* Branded Header & Navbar *}
<div class="row justify-content-center mx-0">
	<div class="px-0">
		<section class="max-w-xl-1200 pt-4 pb-0 pb-mid-md-4 main-content-layout mx-auto" id="headerNavigationContainer">
			<div class="row mx-0 align-items-center justify-content-between ammonite-xs-border">
				<div class="col-9 col-md-8 ps-0 pb-1">
					<a href="{url page="index" router=$smarty.const.ROUTE_PAGE}">
						<img
							src="{$baseUrl}/public/journals/{$currentContext->getId()}/{$displayPageHeaderLogo.uploadName|escape:"url"}"
							alt="{$displayPageHeaderLogo.altText|escape}"
							class="img-fluid"
							style="height: 78px!important;"
						>
					</a>
				</div>
				<div class="col-3 col-md-4 d-flex flex-row-reverse px-0">
					<div class="d-none d-mid-md-block align-items-center justify-content-end">
						{load_menu name="user" path="frontend/components/userNavigationMenu.tpl"}
					</div>

                    <div class="d-flex d-mid-md-none align-items-center justify-content-end">
                        <a class="ammonite-header-section-text p-2 me-2 d-flex align-items-center" href="{url page="search"}">
							<span class="visually-hidden">{translate key="common.search"}</span>
                            <i class="fa fa-solid fa-magnifying-glass" aria-hidden="true"></i>
                        </a>

                        <nav class="navbar navbar-expand-lg">
                            <button
                                    class="navbar-toggler border-0"
                                    type="button"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#collapsibleNavbar"
                                    aria-controls="collapsibleNavbar"
                                    aria-expanded="false"
                                    aria-label="Toggle navigation"
                            >
                                <span class="navbar-toggler-icon"></span>
                            </button>
                        </nav>
                    </div>
				</div>
			</div>
		</section>

		<section class="container-fluid p-0">
			<div class="ammonite-primary-navigation-menu-section menu-row position-relative max-w-xl-1110 mx-auto px-3">
				<nav class="navbar navbar-expand-md ammonite-inner-border-bottom">
					<div class="container-fluid p-0">
						<div class="collapse navbar-collapse w-100" id="collapsibleNavbar">
							{load_menu name="primary" path="frontend/components/primaryNavigationMenu.tpl"}
						</div>
					</div>
				</nav>
			</div>
