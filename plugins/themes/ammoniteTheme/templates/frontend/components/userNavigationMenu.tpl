{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/userNavigationMenu.tpl
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
{if $navigationMenu}
    {foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
        {* Skip undisplayed menu items *}
        {if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
            {continue}
        {/if}
        {* Menu items with children *}
        {if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
            <div class="row mx-0 d-flex d-mid-md-none ammonite-bg-primary">
                <div class="col-5">
                    <ul id="{$id|escape}" class="navbar-nav w-100 justify-content-between">
                        <li class="nav-item dropdown mx-xl-2 ammonite-primary-menu-item ammonite-no-hover pt-1 ammonite-bg-primary">
                            <a id="{$field}" class="ammonite-header-section-text p-2 ps-0 ammonite-parent-menu-item"
                                href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}">
                                {$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="col-7 d-flex flex-column pe-0">
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

            <div class="d-none d-mid-md-block">
                <a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" id="{$field}"
                    class="dropdown-toggle ammonite-header-section-text ammonite-parent-menu-item" data-bs-toggle="dropdown"
                    role="button" aria-expanded="false">
                    {$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                </a>

                {* Children Items *}
                <div class="user-details">
                    <ul class="dropdown-menu" aria-labelledby="{$field}">
                        {foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
                            {if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
                                <li>
                                    <a class="dropdown-item ammonite-header-section-text"
                                        href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}">
                                        {$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                                    </a>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>
                </div>
            </div>
        {else}
            <div class="d-none d-mid-md-inline">
                <a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="ammonite-header-section-text p-2">
                    {$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                </a>
            </div>

            <div class="row mx-0 d-flex d-mid-md-none ammonite-bg-primary">
                <div class="col-5"></div>

                <div class="col-7 d-flex flex-column pe-0">
                    <a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}"
                        class="ammonite-header-menu-item-text p-2 ammonite-submenu-item">
                        {$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                    </a>
                </div>
            </div>
        {/if}
    {/foreach}
{/if}
