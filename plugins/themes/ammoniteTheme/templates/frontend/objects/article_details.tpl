{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article which displays all details about the article.
 *  Expected to be primary object on the page.
 *
 * Many journals will want to add custom data to this object, either through
 * plugins which attach to hooks on the page or by editing the template
 * themselves. In order to facilitate this, a flexible layout markup pattern has
 * been implemented. If followed, plugins and other content can provide markup
 * in a way that will render consistently with other items on the page. This
 * pattern is used in the .main_entry column and the .entry_details column. It
 * consists of the following:
 *
 * <!-- Wrapper class which provides proper spacing between components -->
 * <div class="item">
 *     <!-- Title/value combination -->
 *     <div class="label">Abstract</div>
 *     <div class="value">Value</div>
 * </div>
 *
 * All styling should be applied by class name, so that titles may use heading
 * elements (eg, <h3>) or any element required.
 *
 * <!-- Example: component with multiple title/value combinations -->
 * <div class="item">
 *     <div class="sub_item">
 *         <div class="label">DOI</div>
 *         <div class="value">12345678</div>
 *     </div>
 *     <div class="sub_item">
 *         <div class="label">Published Date</div>
 *         <div class="value">2015-01-01</div>
 *     </div>
 * </div>
 *
 * <!-- Example: component with no title -->
 * <div class="item">
 *     <div class="value">Whatever you'd like</div>
 * </div>
 *
 * Core components are produced manually below, but can also be added via
 * plugins using the hooks provided:
 *
 * Templates::Article::Main
 * Templates::Article::Details
 *
 * @uses $article Submission This article
 * @uses $publication Publication The publication being displayed
 * @uses $firstPublication Publication The first published version of this article
 * @uses $currentPublication Publication The most recently published version of this article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $categories Category The category this article is assigned to
 * @uses $primaryGalleys array List of article galleys that are not supplementary or dependent
 * @uses $supplementaryGalleys array List of article galleys that are supplementary
 * @uses $keywords array List of keywords assigned to this article
 * @uses $pubIdPlugins Array of pubId plugins which this article may be assigned
 * @uses $licenseTerms string License terms.
 * @uses $licenseUrl string URL to license. Only assigned if license should be
 *   included with published submissions.
* @uses $ccLicenseBadge string An image and text with details about the license
 *}

{include file="frontend/components/article_authors_section.tpl"
    publication=$publication
    issue=$issue
    section=$section
    firstPublication=$firstPublication
    article=$article
    orcidIcon=$orcidIcon
}

<div class="max-w-xl-1200 mx-xl-auto main-content-layout">
    {if $section}
        {include file="frontend/components/breadcrumbs_article.tpl" currentTitle=$section->getLocalizedTitle()}
    {else}
        {include file="frontend/components/breadcrumbs_article.tpl" currentTitleKey="common.publication"}
    {/if}
</div>

{$primaryGalleyHasExternalUrl = false}

{foreach from=$primaryGalleys item=galley}
    {if $galley->urlRemote}
        {$primaryGalleyHasExternalUrl = true}
    {/if}
{/foreach}

<article>
    {if $publication->getLocalizedData('subtitle')}
        <div class="row mb-2 px-2 max-w-xl-1200 main-content-layout mx-xl-auto">
            <div class="col">
                <h3 class="fw-light">
                    {$publication->getLocalizedSubTitle(null, 'html')|strip_unsafe_html}
                </h3>
            </div>
        </div>
    {/if}

    {* Main content *}
    <div class="row mx-0 mx-xl-auto mt-3 justify-content-between max-w-xl-1200 main-content-layout">
        <div class="col-3 article-section-hidden-xs px-0">
            {* Article/Issue cover image *}
            {if $publication->getLocalizedData('coverImage') || ($issue && $issue->getLocalizedCoverImage()) || $defaultArticleImage}
                {if $publication->getLocalizedData('coverImage')}
                    {assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
                    <img src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}"
                        alt="{$coverImage.altText|escape|default:''}" class="img-fluid article-cover-image-column">
                {elseif $defaultArticleImage}
                    <img src="{$defaultArticleImage|escape}" alt="{translate key="plugins.themes.ammonite.noArticleCoverImageAltText"}"
                        class="img-fluid article-cover-image-column">
                {else}
                    <a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
                        <img src="{$issue->getLocalizedCoverImageUrl()|escape}"
                            alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}"
                            class="img-fluid d-block mx-auto article-cover-image-column">
                    </a>
                {/if}
            {/if}

            <div class="article-section-hidden-xs mb-5">
                {if $publication->getLocalizedData('abstract')}
                    <div class="row mt-5 mx-0">
                        <span class="ammonite-heading-text scroll-to px-0" data-target="article-abstract">
                            {translate key="article.abstract"}
                        </span>
                    </div>
                {/if}

                {if count($article->getPublishedPublications()) > 1}
                    <div class="row mt-3 mx-0">
                        <span class="ammonite-heading-text scroll-to px-0" data-target="article-versions">
                            {translate key="submission.versions"}
                        </span>
                    </div>
                {/if}

                {if $publication->getLocalizedData('dataAvailability')}
                    <div class="row mt-3">
                        <span class="ammonite-heading-text scroll-to" data-target="article-data-availability">
                            {translate key="submission.dataAvailability"}
                        </span>
                    </div>
                {/if}

                {if $supplementaryGalleys || $primaryGalleyHasExternalUrl}
                    <div class="row mt-3">
                        <span class="ammonite-heading-text scroll-to" data-target="article-supplementary-files">
                            {translate key="plugins.themes.healthSciences.article.supplementaryFiles"}
                        </span>
                    </div>
                {/if}

                {if !empty($publication->getLocalizedData('supportingAgencies')) && !empty($articleMetadataToShow) && "supportingAgencies"|in_array:$articleMetadataToShow}
                    <div class="row mt-3">
                        <span class="ammonite-heading-text scroll-to" data-target="article-fundings">
                            {translate key="plugins.themes.ammonite.funding"}
                        </span>
                    </div>
                {/if}

                <div class="row mt-3">
                    <span class="ammonite-heading-text scroll-to" data-target="article-downloads">
                        {translate key="submission.downloads"}
                    </span>
                </div>

                {if $parsedCitations || $publication->getData('citationsRaw')}
                    <div class="row mt-3">
                        <span class="ammonite-heading-text scroll-to" data-target="article-references">
                            {translate key="submission.citations"}
                        </span>
                    </div>
                {/if}
            </div>

            {* Keywords *}
            {if !empty($publication->getLocalizedData('keywords'))}
                {include file="frontend/components/article_components/keywords_block.tpl" isDesktop=true keywords=$publication->getLocalizedData('keywords')}
            {/if}

            {capture assign="articleDetailsContent"}{call_hook name="Templates::Article::Details"}{/capture}
            {if $articleDetailsContent}
                <div class="mt-2 article-details-hook-blocks" role="complementary">
                    {$articleDetailsContent}
                </div>
            {/if}

            {* Licensing info *}
            {if $currentContext->getLocalizedData('licenseTerms') || $publication->getData('licenseUrl')}
                {include file="frontend/components/article_components/license_block.tpl"
                    publication=$publication
                    currentContext=$currentContext
                    ccLicenseBadge=$ccLicenseBadge
                    isDesktop=true}
            {/if}

            {if $categories && (!empty($articleMetadataToShow) && "categories"|in_array:$articleMetadataToShow || empty($articleMetadataToShow))}
                {include file="frontend/components/article_components/categories_block.tpl" categories=$categories isDesktop=true}
            {/if}

            {if $section && !empty($articleMetadataToShow) && "section"|in_array:$articleMetadataToShow}
                {include file="frontend/components/article_components/section_block.tpl" section=$section isDesktop=true}
            {/if}

            {* Subjects *}
            {if !empty($publication->getLocalizedData('subjects')) && !empty($articleMetadataToShow) && "subjects"|in_array:$articleMetadataToShow}
                {include file="frontend/components/article_components/subjects_block.tpl"
                    subjects=$publication->getLocalizedData('subjects')
                    isDesktop=true}
            {/if}

            {* Discipline *}
            {if !empty($publication->getLocalizedData('disciplines')) && !empty($articleMetadataToShow) && "disciplines"|in_array:$articleMetadataToShow}
                {include file="frontend/components/article_components/disciplines_block.tpl"
                    disciplines=$publication->getLocalizedData('disciplines')
                    isDesktop=true}
            {/if}

            {* Coverage *}
            {if !empty($publication->getLocalizedData('coverage')) && !empty($articleMetadataToShow) && "coverage"|in_array:$articleMetadataToShow}
                {include file="frontend/components/article_components/coverage_block.tpl"
                    coverage=$publication->getLocalizedData('coverage')
                    isDesktop=true}
            {/if}

            {* Rights *}
            {if !empty($publication->getLocalizedData('rights')) && !empty($articleMetadataToShow) && "rights"|in_array:$articleMetadataToShow}
                {include file="frontend/components/article_components/rights_block.tpl"
                    rights=$publication->getLocalizedData('rights')
                    isDesktop=true}
            {/if}

            {* Source *}
            {if !empty($publication->getLocalizedData('source')) && !empty($articleMetadataToShow) && "source"|in_array:$articleMetadataToShow}
                {include file="frontend/components/article_components/source_block.tpl"
                    source=$publication->getLocalizedData('source')
                    isDesktop=true}
            {/if}

            {* Type *}
            {if !empty($publication->getLocalizedData('type')) && !empty($articleMetadataToShow) && "type"|in_array:$articleMetadataToShow}
                {include file="frontend/components/article_components/type_block.tpl"
                    type=$publication->getLocalizedData('type')
                    isDesktop=true}
            {/if}
        </div>

        <div class="col-12 col-sm-8 px-0">
            <div class="row mx-0">
                {* Notification that this is an old version *}
                {if $currentPublication->getId() !== $publication->getId()}
                    <div class="alert alert-warning" role="alert">
                        {capture assign="latestVersionUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}
                        <span class="ammonite-breadcrumb-text">
                            {translate key="submission.outdatedVersion" datePublished=$publication->getData('datePublished')|date_format:$dateFormatShort urlRecentVersion=$latestVersionUrl|escape}
                        </span>
                    </div>
                {/if}
            </div>

            {if $primaryGalleys}
                <div class="d-flex align-items-center flex-wrap mb-5">
                    {foreach from=$primaryGalleys item=galley}
                        {if !$galley->urlRemote}
                            {include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency') isPrimaryGalley=true}
                        {/if}
                    {/foreach}
                </div>
            {/if}

            {* Abstract *}
            <div class="row mx-0">
                {if $publication->getLocalizedData('abstract')}
                    <h2 class="ammonite-h2-text ammonite-divider px-0" id="article-abstract">
                        {translate key="article.abstract"}
                    </h2>

                    <div class="ammonite-regular-text px-0">
                        {$publication->getLocalizedData('abstract')|strip_unsafe_html}
                    </div>
                {/if}
            </div>

            {* Versions *}
            {if count($article->getPublishedPublications()) > 1}
                <div class="row mx-0">
                    <h2 class="ammonite-h2-text ammonite-divider px-0" id="article-versions">
                        {capture assign=translatedVersions}{translate key="submission.versions"}{/capture}
                        {translate key="semicolon" label=$translatedVersions}
                    </h2>

                    <ul class="px-0" style="padding-left: 0!important;">
                        {foreach from=array_reverse($article->getPublishedPublications()) item=iPublication}

                            {capture assign="name"}
                                {translate key="submission.versionIdentity" datePublished=$iPublication->getData('datePublished')|date_format:$dateFormatShort version=$iPublication->getData('version')}
                            {/capture}
                            <li class="ms-3 ps-4">
                                {if $iPublication->getId() === $publication->getId()}
                                    <span class="ammonite-regular-text mb-2">{$name}</span>
                                {elseif $iPublication->getId() === $currentPublication->getId()}
                                    <a class="ammonite-regular-text mb-2 text-decoration-underline" href="{url page="article" op="view" path=$article->getBestId()}">
                                        {$name}
                                    </a>
                                {else}
                                    <a class="ammonite-regular-text mb-2 text-decoration-underline" href="{url page="article" op="view" path=$article->getBestId()|to_array:"version":$iPublication->getId()}">
                                        {$name}
                                    </a>
                                {/if}
                            </li>
                        {/foreach}
                    </ul>
                </div>
            {/if}

            <div class="row mx-0 d-sm-none">
                <div class="col-12 px-0">
                    {* Keywords *}
                    {if !empty($publication->getLocalizedData('keywords'))}
                        {include file="frontend/components/article_components/keywords_block.tpl" isDesktop=false keywords=$publication->getLocalizedData('keywords')}
                    {/if}

                    {capture assign="articleDetailsContent"}{call_hook name="Templates::Article::Details"}{/capture}
                    {if $articleDetailsContent}
                        <div class="mt-2 article-details-hook-blocks" role="complementary">
                            {$articleDetailsContent}
                        </div>
                    {/if}

                    {* Licensing info *}
                    {if $currentContext->getLocalizedData('licenseTerms') || $publication->getData('licenseUrl')}
                        {include file="frontend/components/article_components/license_block.tpl"
                            publication=$publication
                            currentContext=$currentContext
                            ccLicenseBadge=$ccLicenseBadge
                            isDesktop=false}
                    {/if}

                    {if $categories && (!empty($articleMetadataToShow) && "categories"|in_array:$articleMetadataToShow || empty($articleMetadataToShow))}
                        {include file="frontend/components/article_components/categories_block.tpl" categories=$categories isDesktop=false}
                    {/if}

                    {if $section && !empty($articleMetadataToShow) && "section"|in_array:$articleMetadataToShow}
                        {include file="frontend/components/article_components/section_block.tpl" section=$section isDesktop=false}
                    {/if}

                    {* Subjects *}
                    {if !empty($publication->getLocalizedData('subjects')) && !empty($articleMetadataToShow) && "subjects"|in_array:$articleMetadataToShow}
                        {include file="frontend/components/article_components/subjects_block.tpl"
                            subjects=$publication->getLocalizedData('subjects')
                            isDesktop=false}
                    {/if}

                    {* Discipline *}
                    {if !empty($publication->getLocalizedData('disciplines')) && !empty($articleMetadataToShow) && "disciplines"|in_array:$articleMetadataToShow}
                        {include file="frontend/components/article_components/disciplines_block.tpl"
                            disciplines=$publication->getLocalizedData('disciplines')
                            isDesktop=false}
                    {/if}

                    {* Coverage *}
                    {if !empty($publication->getLocalizedData('coverage')) && !empty($articleMetadataToShow) && "coverage"|in_array:$articleMetadataToShow}
                        {include file="frontend/components/article_components/coverage_block.tpl"
                            coverage=$publication->getLocalizedData('coverage')
                            isDesktop=false}
                    {/if}

                    {* Rights *}
                    {if !empty($publication->getLocalizedData('rights')) && !empty($articleMetadataToShow) && "rights"|in_array:$articleMetadataToShow}
                        {include file="frontend/components/article_components/rights_block.tpl"
                            rights=$publication->getLocalizedData('rights')
                            isDesktop=false}
                    {/if}

                    {* Source *}
                    {if !empty($publication->getLocalizedData('source')) && !empty($articleMetadataToShow) && "source"|in_array:$articleMetadataToShow}
                        {include file="frontend/components/article_components/source_block.tpl"
                            source=$publication->getLocalizedData('source')
                            isDesktop=false}
                    {/if}

                    {* Type *}
                    {if !empty($publication->getLocalizedData('type')) && !empty($articleMetadataToShow) && "type"|in_array:$articleMetadataToShow}
                        {include file="frontend/components/article_components/type_block.tpl"
                            type=$publication->getLocalizedData('type')
                            isDesktop=false}
                    {/if}
                </div>
            </div>

            {* Data Availability Statement *}
            {if $publication->getLocalizedData('dataAvailability')}
                <div class="row mb-5 mx-0">
                    <h2 class="ammonite-h2-text ammonite-divider px-0" id="article-data-availability">
                        {translate key="submission.dataAvailability"}
                    </h2>

                    <div class="ammonite-regular-text px-0">
                        {$publication->getLocalizedData('dataAvailability')|strip_unsafe_html}
                    </div>
                </div>
            {/if}

            {* Supplementary Files / Galleys *}
            {if $supplementaryGalleys || $primaryGalleyHasExternalUrl}
                <div class="row mb-5 mx-0" id="article-supplementary-files">
                    <h2 class="ammonite-h2-text ammonite-divider px-0">
                        {translate key="plugins.themes.healthSciences.article.supplementaryFiles"}
                    </h2>

                    <ul class="px-0" style="padding-left: 0!important;">
                        {foreach from=$supplementaryGalleys item=galley}
                            {include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley isSupplementary="1" fullWidthStacking=true articleDetails=true}
                        {/foreach}

                        {foreach from=$primaryGalleys item=galley}
                            {if $galley->urlRemote}
                                {include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley isSupplementary="1" fullWidthStacking=true articleDetails=true}
                            {/if}
                        {/foreach}
                    </ul>
                </div>
            {/if}

            {* Funding / Supporting Agencies *}
            {if !empty($articleMetadataToShow) && 'supportingAgencies'|in_array:$articleMetadataToShow && !empty($publication->getLocalizedData('supportingAgencies'))}
                <div class="row mt-2 mx-0" id="article-fundings">
                    <h2 class='ammonite-h2-text ammonite-divider px-0'>
                        {translate key="plugins.themes.ammonite.funding"}
                    </h2>

                    {foreach name="supportAgency" from=$publication->getLocalizedData('supportingAgencies') item="supportAgency"}
                        <span class='ammonite-regular-text px-0'>
                            {$supportAgency|escape}
                        </span>
                    {/foreach}
                </div>
            {/if}

            {* Metrics *}
            <div class='row mx-0 mt-5 mb-3 ammonite-metrics' id='article-downloads'>
                {* Usage statistics chart*}
                {$activeTheme->displayUsageStatsGraph($article->getId())}
                <h2 class="ammonite-h2-text ammonite-divider px-0">
                    {translate key="submission.downloads"}
                </h2>

                <div class="ps-0">
                    <canvas class="usageStatsGraph" data-object-type="Submission"
                        data-object-id="{$article->getId()|escape}"></canvas>

                    <div class="usageStatsUnavailable" data-object-type="Submission"
                        data-object-id="{$article->getId()|escape}">
                        {translate key="plugins.themes.healthSciences.displayStats.noStats"}
                    </div>
                </div>
            </div>
        </div>
    </div>

    {if $issue}
        <div class="ammonite-issue-content-section max-w-xl-1200 mx-0 mx-xl-auto" style="background-color: rgba(235, 244, 246, 1);">
            <div
                class='row justify-content-between align-items-center mx-0 mx-xl-auto max-w-xl-1200 main-content-layout py-4'>
                <div
                    class='col-12 {if !!$issue->getLocalizedCoverImageUrl() || $defaultIssueCoverImg}col-lg-8{/if} ps-0'>
                    <div class='row mx-0'>
                        <span class='ammonite-h1-text px-0'>
                            {translate key="plugins.themes.ammonite.readMoreInThisIssue"}
                        </span>
                    </div>

                    {*  Description *}
                    {if $issue->hasDescription()}
                        {$words = explode(' ', $issue->getLocalizedDescription()|strip_unsafe_html)}
                        {$first_50_words = array_slice($words, 0, 50)}
                        {$formatted_text = implode(' ', $first_50_words)}

                        {if count($words) > 50}
                            {$formatted_text = $formatted_text|cat:' [...]'}
                        {/if}
                        <div class='row mx-0'>
                            <span class='ammonite-regular-text mb-2 ps-0'>
                                {$formatted_text}
                            </span>
                        </div>
                    {/if}

                    <div class='row mx-0'>
                        <a class='ammonite-regular-text mb-2 text-decoration-none d-flex align-items-center ps-0'
                            style="font-weight: var(--font-weight-bold)!important;"
                            href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
                            {translate key="plugins.themes.ammonite.browseCurrentIssue"}
                            <span class="ammonite-link-icon ms-2">></span>
                        </a>
                    </div>
                </div>

                {assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
                {assign var=issueCoverAltText value=$issue->getLocalizedCoverImageAltText()}

                {if $issueCover || $defaultIssueCoverImg}
                    <div class='col-lg-4 px-0 d-flex issue-cover-image-section px-0 mt-4 mt-lg-0'>
                        <a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
                            <img
                                src="{if !!$issueCover}{$issueCover|escape}{elseif $defaultIssueCoverImg}{$defaultIssueCoverImg|escape}{/if}"
                                alt="
                                    {if !!$issueCover}
                                        {$issueCoverAltText|escape|default:$defaultAltText}
                                    {elseif $defaultIssueCoverImg}
                                        {translate key="plugins.themes.ammonite.noIssueCoverImageAltText"}
                                    {/if}"
                                class="w-100 img-cover px-5 px-lg-0"
                                id='issueCoverImage'
                            >
                        </a>
                    </div>
                {/if}
            </div>
        </div>
    {/if}

    <div class='row justify-content-end mx-0 mx-xl-auto max-w-xl-1200 main-content-layout'>
        <div class='col-12 col-md-8'>
            {* References *}
            <div class='row mt-0 mt-sm-5'>
                {if $parsedCitations || $publication->getData('citationsRaw')}
                    <h2 class='ammonite-h2-text ammonite-divider px-0' id='article-references'>
                        {translate key="submission.citations"}
                    </h2>

                    {if $parsedCitations}
                        <ul class='list-unstyled px-0'>
                            {foreach from=$parsedCitations item="parsedCitation"}
                                <li class='ammonite-regular-text text-break'>
                                    {$parsedCitation->getCitationWithLinks()|strip_unsafe_html}
                                    {call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}
                                </li>
                            {/foreach}
                        </ul>
                    {else}
                        <div class='ammonite-regular-text'>
                            {$publication->getData('citationsRaw')|escape|nl2br}
                        </div>
                    {/if}
                {/if}
            </div>
        </div>
    </div>

    <div class='row justify-content-end mx-0 mx-xl-auto max-w-xl-1200 main-content-layout'>
        <div class='col-12 col-md-8'>
            {call_hook name="Templates::Article::Main"}
        </div>
    </div>

    <div class='row justify-content-end mx-0 mx-xl-auto max-w-xl-1200 main-content-layout'>
        <div class='col-12 col-md-8 px-0 ammonite-article-footer-hook'>
            {call_hook name="Templates::Article::Footer::PageFooter"}
        </div>
    </div>
</article>

<script>
    document.querySelectorAll('.scroll-to').forEach(function(span) {
        span.addEventListener('click', function() {
            const targetId = span.getAttribute('data-target');
            const targetElement = document.getElementById(targetId);

            if (targetElement) {
                targetElement.scrollIntoView({ behavior: 'smooth' });
            }
        });
    });

    document.addEventListener("DOMContentLoaded", function() {
        const shareTextElements = document.querySelectorAll('.share_text');

        shareTextElements.forEach(element => {
            element.parentNode.removeChild(element);
        });
    });
</script>
