{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/article_authors_section.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Section to show authors on article page.
 *
 * @uses $publication Submission current submission
 * @uses $issue Issue issue for this submisison
 * @uses $section Section section for this submission
 * @uses $firstPublication Submission first version of this submission
 * @uses $article Submission article
 * @uses $orcidIcon ORCiD icon
 *
 *}

<div class="ammonite-article-main-section row mx-0 mx-xl-auto max-w-xl-1200">
    <div class="row mx-0 mx-xl-auto max-w-xl-1200 main-content-layout py-2 py-md-4 px-tablet-0">
        <div class="col-12 px-0">
            {if $issue}
                <div class="row max-w-sm-900 my-3 my-md-0">
                    <span class="ammonite-breadcrumb-text">
                        {translate key="issue.vol"} {$issue->getVolume()|escape} ({$issue->getYear()|escape})
                        {if $issue->getNumber()}|
                            {translate key="issue.number"} {$issue->getNumber()|escape}
                        {/if}
                    </span>
                </div>
            {/if}

            <div class="row max-w-sm-900">
                <h1 class="ammonite-h2-text">
                    {$publication->getLocalizedTitle(null, 'html')|strip_unsafe_html}
                </h1>
            </div>

            <div class="row d-none d-md-flex align-items-center justify-content-between max-w-sm-900 mb-4">
                <div class="col-4">
                    <span class="ammonite-breadcrumb-text">
                        {$section->getLocalizedTitle()|escape}
                    </span>
                </div>

                <div class="col-4">
                    {* Dates and versions *}
                    {if $publication->getData('datePublished')}
                        <span class="ammonite-breadcrumb-text">
                            {*  If this is the original version*}
                            {if $firstPublication->getID() === $publication->getId()}
                                {translate key="submissions.published"}
                                {$firstPublication->getData('datePublished')|date_format:$dateFormatLong}
                                {*  If this is an updated version*}
                            {else}
                                {translate key="submission.updatedOn" datePublished=$firstPublication->getData('datePublished')|date_format:$dateFormatShort dateUpdated=$publication->getData('datePublished')|date_format:$dateFormatShort}
                            {/if}
                        </span>
                    {/if}
                </div>

                <div class="col-4">
                    {* DOI (requires plugin) *}
                    {assign var=doiObject value=$article->getCurrentPublication()->getData('doiObject')}
                    {if $doiObject}
                        {assign var="doiUrl" value=$doiObject->getData('resolvingUrl')|escape}
                        <a href="{$doiUrl}" class="ammonite-breadcrumb-text text-decoration-none">
                            {$doiUrl}
                        </a>
                    {/if}
                </div>
            </div>

            {* Authors *}
            {if $publication->getData('authors')}
                <div class="d-flex flex-wrap align-items-center mt-1">
                    {foreach from=$publication->getData('authors') item=author}
                        {assign var=hasSubInfo value=($author->getLocalizedData('affiliation')||$author->getData('orcid'))}

                        <span class="ammonite-regular-text mb-0 align-items-center ammonite-author d-flex">
                            {$author->getFullName()|escape}
                            {if $author->getData('orcid') or $author->getLocalizedData('affiliation')}
                                <div class="ammonite-breadcrumb-text ammonite-author-data cursor-pointer d-flex align-items-center"
                                    style="color: #0c63e4;"
                                    data-affiliation="{if $author->getLocalizedData('affiliation')}{$author->getLocalizedData('affiliation')|escape}{else}{/if}"
                                    data-author="{$author->getFullName()|escape}"
                                    data-orcid="{if $author->getData('orcid')}{$author->getData('orcid')|escape}{else}{/if}">
                                    <span class="plus-minus-icon ms-1">+</span>
                                    {if $orcidIcon && $author->getData('orcid')}
                                        {if $orcidIcon}
                                            <div>{$orcidIcon}</div>
                                        {else}
                                            <img src="{$baseUrl}/{$orcidImage}">
                                        {/if}
                                    {/if}
                                </div>
                            {/if}
                            {if !$author@last},&nbsp;{/if}
                        </span>
                    {/foreach}
                </div>
            {/if}

            <div class="row d-flex d-md-none align-items-center justify-content-between max-w-sm-900 mt-4">
                <div class="col-12">
                    <span class="ammonite-breadcrumb-text">
                        {$section->getLocalizedTitle()|escape}
                    </span>
                </div>

                <div class="col-12">
                    {* Dates and versions *}
                    {if $publication->getData('datePublished')}
                        <span class="ammonite-breadcrumb-text">
                            {*  If this is the original version*}
                            {if $firstPublication->getID() === $publication->getId()}
                                {translate key="submissions.published"}
                                {$firstPublication->getData('datePublished')|date_format:$dateFormatLong}
                                {*  If this is an updated version*}
                            {else}
                                {translate key="submission.updatedOn" datePublished=$firstPublication->getData('datePublished')|date_format:$dateFormatShort dateUpdated=$publication->getData('datePublished')|date_format:$dateFormatShort}
                            {/if}
                        </span>
                    {/if}
                </div>

                <div class="col-12">
                    {* DOI (requires plugin) *}
                    {assign var=doiObject value=$article->getCurrentPublication()->getData('doiObject')}
                    {if $doiObject}
                        {assign var="doiUrl" value=$doiObject->getData('resolvingUrl')|escape}
                        <a href="{$doiUrl}" class="ammonite-breadcrumb-text text-decoration-none">
                            {$doiUrl}
                        </a>
                    {/if}
                </div>
            </div>

            <div class="row mt-5">
                <div class="col-12 d-flex justify-content-center ammonite-breadcrumb-text text-center"
                    id="affiliation-field"></div>
                <div class="col-12 d-flex justify-content-center ammonite-breadcrumb-text text-center">
                    <a href="" id="author-orcid-field" target="_blank"></a>
                </div>
                <div style="display: none;" id="author-fullname"></div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        var authorsData = document.querySelectorAll('.ammonite-author-data');

        authorsData.forEach(authorData => {
            authorData.addEventListener("click", function() {
                var affiliationValue = authorData.getAttribute('data-affiliation');
                var authorValue = authorData.getAttribute('data-author');

                var affiliationField = document.getElementById('affiliation-field');
                var orcidField = document.getElementById('author-orcid-field');
                var authorFullname = document.getElementById('author-fullname');

                document.querySelectorAll('.ammonite-author').forEach(author => author.style
                    .color =
                    'black');
                document.querySelectorAll(".plus-minus-icon").forEach(author => author
                    .textContent = "+");

                var plusMinusIcon = authorData.querySelector('.plus-minus-icon');
                plusMinusIcon.textContent = plusMinusIcon.textContent === "+" ? "-" : "+";

                if (affiliationValue === affiliationField.textContent && authorValue === authorFullname.textContent) {
                    affiliationField.textContent = "";
                    orcidField.textContent = "";
                    orcidField.href = "";
                    plusMinusIcon.textContent = "+";
                    authorFullname.textContent = "";
                    return;
                }

                var parentSpan = authorData.closest('.ammonite-regular-text');

                if (parentSpan) {
                    parentSpan.style.color = '#0c63e4';
                    plusMinusIcon.textContent = "-";
                }

                affiliationField.textContent = affiliationValue;

                var orcidValue = authorData.getAttribute('data-orcid');
                if (orcidValue && orcidValue.trim() !== '') {
                    orcidField.textContent = orcidValue;
                    orcidField.href = orcidValue;
                } else {
                    orcidField.textContent = '';
                    orcidField.href = '';
                }
                authorFullname.textContent = authorValue;
            });
        });
    });
</script>
