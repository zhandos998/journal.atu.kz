<?php

/**
 * @file plugins/themes/ammoniteTheme/AmmoniteThemePlugin.php
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class AmmoniteThemePlugin
 * @ingroup plugins_themes_ammonite
 *
 * @brief Ammonite theme
 */

namespace APP\plugins\themes\ammoniteTheme;

use APP\core\Application;
use APP\facades\Repo;
use APP\journal\Journal;
use APP\notification\NotificationManager;
use APP\plugins\themes\ammoniteTheme\classes\acessibility\ContrastColor;
use APP\plugins\themes\ammoniteTheme\classes\AnnouncementManager;
use APP\plugins\themes\ammoniteTheme\classes\CategoryManager;
use APP\plugins\themes\ammoniteTheme\classes\PublisherLibraryManager;
use APP\plugins\themes\ammoniteTheme\classes\SubmissionManager;
use APP\submission\Submission;
use PKP\notification\Notification;
use PKP\plugins\Hook;
use PKP\plugins\PluginRegistry;
use PKP\plugins\ThemePlugin;

class AmmoniteThemePlugin extends ThemePlugin
{
    /** Plugin registry key of the required parent theme. */
    private const PARENT_THEME_KEY = 'healthsciencesthemeplugin';

    private array $cachedCategories = [];

    /**
     * @copydoc \PKP\plugins\ThemePlugin::init()
     */
    public function init()
    {
        // Ammonite is a child of the Health Sciences theme. Without that parent
        // installed the styles, templates and options it inherits are missing,
        // so refuse to register anything and surface a notice to admins.
        if (!$this->isParentThemeAvailable()) {
            $this->registerMissingParentNotice();
            return;
        }

        $this->setParent(self::PARENT_THEME_KEY);

        $this->addMenuArea(['primary', 'user', 'footer', 'footerSocialMedia']);

        $this->cachedCategories = CategoryManager::loadCategoriesByContextId($this->getJournal()->getId());

        $this->setupOptions();

        // CSS and JS
        $this->addStyle('font-body', 'css/open-sans.css');

        $this->addStyle('font-awesome', 'css/fa_all.min.css');
        $this->addStyle('custom-theme-style', 'less/index.less');

        $this->addScript('jquery', 'js/jquery.js');
        $this->addScript('manageIssueSectionBgColor', 'js/manageIssueSectionBgColor.js');
        $this->addScript('custom-js', 'js/custom.js');

        Hook::add('TemplateManager::display', [$this, 'siteWideData']);
        Hook::add('TemplateManager::display', [$this, 'hasEmbeddedCSS']);
        Hook::add('TemplateManager::display', [$this, 'getPaginatedSubmissionsByCategories']);
        Hook::add('TemplateManager::display', [$this, 'loadSubcategoriesFromSubmissions']);

        // Update background and text color LESS variables based on the baseColour theme option
        $this->getTextColorForAccessibility();
    }

    /**
     * Check whether the Health Sciences parent theme is installed and registered.
     */
    private function isParentThemeAvailable(): bool
    {
        return PluginRegistry::getPlugin('themes', self::PARENT_THEME_KEY) instanceof ThemePlugin;
    }

    /**
     * Flash a warning on the website settings page when an admin lands there
     * without the required parent theme installed.
     */
    private function registerMissingParentNotice(): void
    {
        Hook::add('TemplateManager::display', function ($hookName, $args) {
            $template = $args[1] ?? null;
            if ($template !== 'management/website.tpl') {
                return false;
            }

            $user = Application::get()->getRequest()->getUser();
            if (!$user) {
                return false;
            }

            $notificationMgr = new NotificationManager();
            $notificationMgr->createTrivialNotification(
                $user->getId(),
                Notification::NOTIFICATION_TYPE_WARNING,
                ['contents' => __('plugins.themes.ammonite.parentMissing')]
            );

            return false;
        });
    }

    /**
     * @copydoc \PKP\plugins\ThemePlugin::getDisplayName()
     */
    public function getDisplayName()
    {
        return __('plugins.themes.ammonite.name');
    }

    /**
     * @copydoc \PKP\plugins\ThemePlugin::getDescription()
     */
    public function getDescription()
    {
        return __('plugins.themes.ammonite.description');
    }

    /**
     * Injects data that is accessible site-wide into the template manager
     *
     * @param string $hookName
     * @param array $args [
     * @option TemplateManager $templateMgr
     * @option string $template
     * ]
     */
    public function siteWideData(string $hookName, array $args)
    {
        $templateMgr = $args[0];
        $request = $this->getRequest();
        $site = $request->getSite();
        $context = $request->getContext();
        $router = $request->getRouter();

        $announcements = AnnouncementManager::getStaticAnnouncements($context->getId());

        $templateMgr->assign('announcements', $announcements);
        $templateMgr->assign('siteWideDisplayPageHeaderLogo', $context->getLocalizedData('pageHeaderLogoImage'));
        $templateMgr->assign('siteWideDisplayPageHeaderLogoAltText', $site->getLocalizedData('pageHeaderLogoImageAltText'));
        $templateMgr->assign('brandImage', 'templates/images/ojs_brand.png');
        $templateMgr->assign('footerClientLogo', $router->url($request, null, 'libraryFiles', 'downloadPublic', [$this->getOption('footerClientLogo')]));
        $templateMgr->assign('defaultIssueCoverImg', $router->url($request, null, 'libraryFiles', 'downloadPublic', [$this->getOption('issueDefaultCoverImage')]));
        $templateMgr->assign('defaultArticleImage', $router->url($request, null, 'libraryFiles', 'downloadPublic', [$this->getOption('defaultArticleImage')]));
        $templateMgr->assign('primaryColour', $this->getOption('baseColour'));
        $templateMgr->assign('articleMetadataToShow', $this->getOption('articleMetadataToShow') ?? []);
    }

    /**
     * Checks if the HTML galley has embedded CSS
     *
     * @param string $hookName
     * @param array $args [
     * @option TemplateManager $templateMgr
     * @option string $template
     * ]
     */
    public function hasEmbeddedCSS(string $hookName, array $args)
    {
        $templateMgr = $args[0];
        $template = $args[1];
        $request = $this->getRequest();

        // Return false if not a galley page
        if ($template !== 'plugins/plugins/generic/htmlArticleGalley/generic/htmlArticleGalley:display.tpl') {
            return false;
        }

        $articleArrays = $templateMgr->getTemplateVars('article');

        // Default styling for HTML galley
        $boolEmbeddedCss = false;
        foreach ($articleArrays->getGalleys() as $galley) {
            if ($galley->getFileType() === 'text/html') {
                $submissionFile = $galley->getFile();

                $submissionFileRepository = Repo::submissionFile();
                $revisionRecords = $submissionFileRepository->getRevisions($submissionFile->getId())->toArray();
                $dependentFiles = $submissionFileRepository->getCollector()
                    ->filterByAssoc(Application::ASSOC_TYPE_SUBMISSION_FILE, [$submissionFile->getId()])
                    ->includeDependentFiles()
                    ->getMany()
                    ->toArray();
                $embeddableFiles = array_merge($revisionRecords, $dependentFiles);

                foreach ($embeddableFiles as $embeddableFile) {
                    if ($embeddableFile->getFileType() == 'text/css') {
                        $boolEmbeddedCss = true;
                    }
                }
            }
        }

        $templateMgr->assign([
            'boolEmbeddedCss' => $boolEmbeddedCss,
            'themePath' => "{$request->getBaseUrl()}/{$this->getPluginPath()}",
        ]);
    }

    /**
     * Retrieves paginated submissions by categories for the index journal page
     *
     * @param string $hookName
     * @param array $args [
     * @option TemplateManager $templateMgr
     * @option string $template
     * ]
     */
    public function getPaginatedSubmissionsByCategories(string $hookName, array $args)
    {
        $templateMgr = $args[0];
        $template = $args[1];

        if ($template !== 'frontend/pages/indexJournal.tpl') {
            return false;
        }

        $categories = [];
        $categorySubmissions = [];

        foreach($this->getOption('categoriesToShowArticles') as $categoryId) {
            $category = Repo::category()->get($categoryId);
            $categorySubmissionsInner = SubmissionManager::getFilteredSubmissionsByCategoryId(
                $categoryId,
                $this->getJournal()->getId(),
                $this->getOption('submissionsQtd'),
                $this->getOption('categoryToSearchChildrenOnArticle')
            );

            if (!count($categorySubmissionsInner->toArray())) {
                continue;
            }

            $categories[] = $category;
            $categorySubmissions[] = $categorySubmissionsInner;
        }

        [$categoryToListSubs, $listSubcategories] = CategoryManager::getCategoryToListSubsVariables($this->getOption('categoryToListSubcategories'));

        $templateMgr->assign([
            'categories' => $categories,
            'categorySubmissions' => $categorySubmissions,
            'categoryToListSubs' => $categoryToListSubs,
            'listSubcategories' => $listSubcategories,
        ]);
    }

    /**
     * Retrieves the current context
     */
    private function getJournal(): Journal
    {
        return Application::get()->getRequest()->getJournal();
    }

    /**
     * Sets up the theme options
     */
    private function setupOptions(): void
    {
        $this->addOption('journalNewsBackgroundColor', 'colour', [
            'label' => 'plugins.themes.ammonite.settings.journalNewsColour.label',
            'description' => 'plugins.themes.ammonite.settings.journalNewsColour.description',
            'default' => '#000000',
        ]);

        $this->addOption('informationBackgroundColor', 'colour', [
            'label' => 'plugins.themes.ammonite.settings.informationBlockColour.label',
            'description' => 'plugins.themes.ammonite.settings.informationBlockColour.description',
            'default' => '#d2dae4',
        ]);

        $this->addOption('homepageInformationBlockTitle', 'FieldText', [
            'label' => __('plugins.themes.ammonite.homepageInformationTitle.label'),
            'description' => __('plugins.themes.ammonite.homepageInformationTitle.description')
        ]);

        $this->addOption('homepageInformationBlockContent', 'FieldRichTextarea', [
            'label' => __('plugins.themes.ammonite.option.homepageInformationContent.label'),
            'description' => __('plugins.themes.ammonite.option.homepageInformationContent.description')
        ]);

        $this->addOption('submissionsQtd', 'FieldText', [
            'label' => __('plugins.themes.ammonite.option.submissionsQtd.label'),
            'description' => __('plugins.themes.ammonite.option.submissionsQtd.description'),
            'default' => '3'
        ]);

        $parentCategoriesOptions = CategoryManager::getParentCategoriesFromCategoryList($this->cachedCategories);

        $this->addOption('categoriesToShowArticles', 'FieldOptions', [
            'label' => __('plugins.themes.ammonite.categoriesToShowArticlesLabel'),
            'description' => __('plugins.themes.ammonite.categoriesToShowArticlesDescription'),
            'options' => $parentCategoriesOptions,
            'isOrderable' => true,
            'default' => [],
        ]);

        $this->addOption(
            'categoryToListSubcategories',
            'FieldSelect',
            [
                'label' => __('plugins.themes.ammonite.option.categoryToListSubcategories.label'),
                'description' => __('plugins.themes.ammonite.option.categoryToListSubcategories.description'),
                'options' => [
                    ['label' => __('plugins.themes.ammonite.option.none'), 'value' => null],
                    ...$parentCategoriesOptions
                ]
            ]
        );

        $this->addOption(
            'categoryToSearchChildrenOnArticle',
            'FieldSelect',
            [
                'label' => __('plugins.themes.ammonite.settings.categoryToShowChildOnArticle.label'),
                'description' => __('plugins.themes.ammonite.settings.categoryToShowChildOnArticle.description'),
                'options' => [
                    ['label' => __('plugins.themes.ammonite.option.none'), 'value' => null],
                    ...$parentCategoriesOptions
                ]
            ]
        );

        $libraryPublisherFiles = [
            ['value' => '', 'label' => __('plugins.themes.ammonite.option.none')],
            ...PublisherLibraryManager::getPublisherLibraryFiles($this->getJournal())
        ];

        $this->addOption('issueDefaultCoverImage', 'FieldSelect', [
            'label' => __('plugins.themes.ammonite.settings.defaultIssueCoverImage.label'),
            'description' => __('plugins.themes.ammonite.settings.defaultIssueCoverImage.description'),
            'options' => $libraryPublisherFiles,
            'default' => null,
        ]);

        $this->addOption('defaultArticleImage', 'FieldSelect', [
            'label' => __('plugins.themes.ammonite.settings.defaultArticleImage.label'),
            'description' => __('plugins.themes.ammonite.settings.defaultArticleImage.description'),
            'options' => $libraryPublisherFiles,
            'default' => null,
        ]);

        $this->addOption('footerClientLogo', 'FieldSelect', [
            'label' => __('plugins.themes.ammonite.option.footerClientLogo.label'),
            'description' => __('plugins.themes.ammonite.option.footerClientLogo.description'),
            'options' => $libraryPublisherFiles,
            'default' => null,
        ]);

        $this->addOption('footerClientLogoAltText', 'FieldText', [
            'label'=> __('plugins.themes.ammonite.footerClientLogoAltTextLabel'),
            'description' => __('plugins.themes.ammonite.footerClientLogoAltTextDescription')
        ]);

        $this->addOption('footerClientLogoLink', 'FieldText', [
            'label'=> __('plugins.themes.ammonite.footerClientLogoLinkLabel'),
            'description' => __('plugins.themes.ammonite.footerClientLogoLinkDescription')
        ]);

        $this->addOption('articleMetadataToShow', 'FieldOptions', [
            'label' => __('plugins.themes.ammonite.metadataToShowLabel'),
            'description' => __('plugins.themes.ammonite.metadataToShowDescription'),
            'options' => [
                ['value' => 'supportingAgencies', 'label' => __('plugins.themes.ammonite.funding',)],
                ['value' => 'categories', 'label' => __('plugins.themes.ammonite.categoriesDescription')],
                ['value' => 'section', 'label' => __('section.section')],
                ['value' => 'subjects', 'label' => __('common.subjects')],
                ['value' => 'disciplines', 'label' => __('common.discipline')],
                ['value' => 'coverage', 'label' => __('search.coverage')],
                ['value' => 'rights', 'label' => __('submission.rights')],
                ['value' => 'source', 'label' => __('common.source')],
                ['value' => 'type', 'label' => __('common.type')],
            ],
            'default' => [],
        ]);

        $categoriesToShow = $this->getOption('categoriesToShowArticles') ?? [];
        $orderedParentCategoryOptions = CategoryManager::orderCategoriesList($categoriesToShow, $parentCategoriesOptions);

        $this->getOptionConfig('categoriesToShowArticles')->options = $orderedParentCategoryOptions;
    }

    /**
     * Loads subcategories from submissions
     *
     * @param string $hookName
     * @param array $args [
     * @option TemplateManager $templateMgr
     * @option string $template
     * ]
     */
    public function loadSubcategoriesFromSubmissions(string $hookName, array $args)
    {
        $template = $args[1];

        $allowedTemplates = [
            'frontend/pages/catalogCategory.tpl',
            'frontend/pages/issue.tpl'
        ];

        if (!in_array($template, $allowedTemplates)) {
            return false;
        }

        $templateMgr = $args[0];

        if ($template == 'frontend/pages/catalogCategory.tpl') {
            collect($templateMgr->tpl_vars['publishedSubmissions']->value)->each(function (Submission $submission) {
                $submission->firstSubcategory = CategoryManager::getFirstSubcategories(
                    $submission->getCurrentPublication()->getId(),
                    $this->getOption('categoryToSearchChildrenOnArticle')
                );
            });
        }

        if ($template == 'frontend/pages/issue.tpl') {
            $articles = [];

            foreach ($templateMgr->tpl_vars['publishedSubmissions']->value as $submission) {
                foreach ($submission['articles'] as $article) {
                    $articles[] = $article;
                }
            }

            collect($articles)->each(function (Submission $submission) {
                $submission->firstSubcategory = CategoryManager::getFirstSubcategories(
                    $submission->getCurrentPublication()->getId(),
                    $this->getOption('categoryToSearchChildrenOnArticle')
                );
            });
        }
    }

    /**
     * Updates text color for accessibility
     */
    private function getTextColorForAccessibility(): void
    {
        $baseColour = $this->getOption('baseColour');
        $journalNewsBackgroundColor = $this->getOption('journalNewsBackgroundColor');
        $informationBackgroundColor = $this->getOption('informationBackgroundColor');

        if (!preg_match('/^#[0-9a-fA-F]{1,6}$/', $baseColour)) $baseColour = '#1E6292';
        if (!preg_match('/^#[0-9a-fA-F]{1,6}$/', $journalNewsBackgroundColor)) $journalNewsBackgroundColor = '#000000';
        if (!preg_match('/^#[0-9a-fA-F]{1,6}$/', $informationBackgroundColor)) $informationBackgroundColor = '#D2DAE4';

        $accessibilityTextColor = ContrastColor::getContrastColor($baseColour);
        $hoverBackgroundColor = $accessibilityTextColor['color'] === '#FFFFFF' ? '#A1A1A1' : '#FFFFFF';

        $journalNewsAcbltTextColor = ContrastColor::getContrastColor($journalNewsBackgroundColor);
        $informationNewsAcbltTextColor = ContrastColor::getContrastColor($informationBackgroundColor);

        $additionalLessVariables[] = "@primary-colour: {$baseColour};";
        $additionalLessVariables[] = "@colour-info-section: {$informationBackgroundColor};";
        $additionalLessVariables[] = "@colour-news-section: {$journalNewsBackgroundColor};";

        $additionalLessVariables[] = "@text-on-primary-colour: {$accessibilityTextColor['color']};";
        $additionalLessVariables[] = "@colour-on-info-section: {$informationNewsAcbltTextColor['color']};";
        $additionalLessVariables[] = "@colour-on-news-section: {$journalNewsAcbltTextColor['color']};";

        $additionalLessVariables[] = "@colour-on-primary-menu-hover: {$hoverBackgroundColor};";

        $this->modifyStyle('custom-theme-style', ['addLessVariables' => join("\n", $additionalLessVariables)]);
    }

    /** @see ThemePlugin::saveOption */
	public function saveOption($name, $value, $contextId = null) {
		// Validate the base colour setting value.
		if ($name == 'baseColour' && !preg_match('/^#[0-9a-fA-F]{1,6}$/', $value)) $value = null;
        if ($name == 'informationBackgroundColor' && !preg_match('/^#[0-9a-fA-F]{1,6}$/', $value)) $value = null;
        if ($name == 'journalNewsBackgroundColor' && !preg_match('/^#[0-9a-fA-F]{1,6}$/', $value)) $value = null;

		parent::saveOption($name, $value, $contextId);
	}
}
