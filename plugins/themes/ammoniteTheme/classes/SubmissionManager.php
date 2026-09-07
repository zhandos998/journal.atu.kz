<?php

/**
 * @file plugins/themes/ammoniteTheme/classes/SubmissionManager.php
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class SubmissionManager
 * @ingroup plugins_themes_ammonite
 *
 * @brief Submission manager
 */

namespace APP\plugins\themes\ammoniteTheme\classes;

use APP\facades\Repo;
use APP\submission\Submission;

class SubmissionManager
{
    /**
     * Retrieves filtered submissions by category ID
     */
    public static function getFilteredSubmissionsByCategoryId(
        int $categoryId,
        int $contextId,
        int $submissionsQtd = 3,
        ?int $categoryToSearchChildrenOnArticle = null
    )
    {
        return Repo::submission()
            ->getCollector()
            ->filterByContextIds([$contextId])
            ->filterByCategoryIds([$categoryId])
            ->filterByStatus([Submission::STATUS_PUBLISHED])
            ->orderBy('datePublished')
            ->limit($submissionsQtd)
            ->offset(0)
            ->getMany()
            ->map(function (Submission $submission) use ($categoryToSearchChildrenOnArticle) {
                $section = Repo::section()->get($submission->getSectionId());

                $submission->section = $section;
                $submission->firstSubcategory = CategoryManager::getFirstSubcategories(
                    $submission->getCurrentPublication()->getId(),
                    $categoryToSearchChildrenOnArticle
                );

                return $submission;
            });
    }
}
