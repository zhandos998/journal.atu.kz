{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/primaryNavigationMenu.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Primary navigation menu list for OJS
 *
 * @uses navigationMenu array Hierarchical array of navigation menu item assignments
 * @uses id string Element ID to assign the outer <ul>
 * @uses ulClass string Class name(s) to assign the outer <ul>
 * @uses liClass string Class name(s) to assign all <li> elements
 *}
<div class="d-block d-mid-md-none">
    {load_menu name="user" path="frontend/components/userNavigationMenu.tpl"}
</div>

{if $navigationMenu}
    <ul id="{$id|escape}" class="navbar-nav w-100 justify-content-between">
        {foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
            {* Skip undisplayed menu items *}
            {if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
                {continue}
            {/if}
            {* Menu items with children *}
            {if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
                <li class="nav-item dropdown me-xl-2 ammonite-primary-menu-item ammonite-no-hover pt-1">
                    <div class="row d-flex d-mid-md-none">
                        <div class="col-5">
                            <a id="{$field}" class="ammonite-header-section-text p-2 ammonite-parent-menu-item"
                                href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}">
                                {$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                            </a>
                        </div>
                        <div class="col-7 d-flex flex-column">
                            {foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
                                {if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
                                    <a class="ammonite-header-menu-item-text p-2 ammonite-submenu-item"
                                        href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}">
                                        {$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                                    </a>
                                {/if}
                            {/foreach}
                        </div>
                    </div>

                    <a id="{$field}" class="nav-link dropdown-toggle ammonite-header-section-text p-2 ps-0 d-none d-mid-md-block"
                        data-bs-toggle="dropdown" aria-expanded="false" role="button" href="#">
                        {$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                    </a>
                    {*	 Children Items     *}
                    <ul class="dropdown-menu ammonite-primary-navigation-menu py-3" aria-labelledby="{$field}">
                        {foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
                            {if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
                                <li class="submenu">
                                    <a class="dropdown-item ammonite-header-menu-item-text p-2"
                                        href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}">
                                        {$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                                    </a>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>
                </li>
                <div class="pb-2 pb-md-0 ammonite-bg-primary"></div>
            {else}
                <li class="nav-item ms-0 ammonite-primary-menu-item ammonite-no-hover d-flex align-items-center">
                    <a class="nav-link ammonite-header-section-text ammonite-parent-menu-item"
                        href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}">
                        {$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                    </a>
                </li>
                <div class="pb-2 pb-md-0 ammonite-bg-primary"></div>
            {/if}
        {/foreach}

        <div class="d-none d-mid-md-flex align-items-center">
            <div class="row justify-content-between flex-nowrap">
                <div class="col d-flex">
                    {if $currentContext && $requestedPage !== 'search'}
                        <a class="ammonite-header-section-text py-2 d-flex align-items-center justify-content-end"
                            href="{url page="search"}">
                            <span>{translate key="common.search"}&nbsp;</span>
                            <i class="fa fa-solid fa-magnifying-glass" aria-hidden="true"></i>
                        </a>
                    {/if}
                    <a href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="gateway" op="plugin" path="WebFeedGatewayPlugin"|to_array:"rss"}"
                        class="ammonite-header-section-text py-2 ms-3 text-nowrap d-flex align-items-center">
                        {translate key="plugins.themes.ammonite.rssFeed"}
                    </a>
                </div>
            </div>
        </div>
    </ul>
{/if}
