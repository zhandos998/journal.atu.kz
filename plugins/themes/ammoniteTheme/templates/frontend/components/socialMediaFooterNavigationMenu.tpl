{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/socialMediaFooterNavigationMenu.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Social Media footer navigation menu list for OJS
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

        <a
            href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}"
            class="text-decoration-none {if $navigationMenuItemAssignment@index > 0}ms-2{/if}"
            target="_blank"
        >
            {capture assign="socialMediaIcon"}
                {if $navigationMenuItemAssignment->navigationMenuItem->getUrl()|strstr:"youtube"}
                    <img src="{$baseUrl}/plugins/themes/ammoniteTheme/images/youtube_social_icon_dark.png" alt="YouTube" width="36"
                        height="26" />
                {elseif $navigationMenuItemAssignment->navigationMenuItem->getUrl()|strstr:"twitter"}
                    <img src="{$baseUrl}/plugins/themes/ammoniteTheme/images/logo-black.png" alt="X" width="26"
                        height="26" />
                {elseif $navigationMenuItemAssignment->navigationMenuItem->getUrl()|strstr:"linkedin"}
                    <img src="{$baseUrl}/plugins/themes/ammoniteTheme/images/LI-In_black.png" alt="LinkedIn" width="30"
                        height="26" />
                {elseif $navigationMenuItemAssignment->navigationMenuItem->getUrl()|strstr:"instagram"}
                    <img src="{$baseUrl}/plugins/themes/ammoniteTheme/images/instagram_logo_black_nd_white.png"
                        alt="Instagram" width="26" height="26" />
                {/if}
            {/capture}
            {$socialMediaIcon}
        </a>
    {/foreach}
{/if}
