{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/footerNavigationMenu.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Footer navigation menu list for OJS
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
        <div class="row mb-3">
            <a class="ammonite-footer-link-text" href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}">
                {$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
            </a>
        </div>
    {/foreach}
 {/if}
