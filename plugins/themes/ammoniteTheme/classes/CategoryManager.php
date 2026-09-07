<?php

/**
 * @file plugins/themes/ammoniteTheme/classes/CategoryManager.php
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class CategoryManager
 * @ingroup plugins_themes_ammonite
 *
 * @brief Category manager
 */

namespace APP\plugins\themes\ammoniteTheme\classes;

use APP\facades\Repo;
use PKP\category\Category;

class CategoryManager
{

    /**
     * Retrieves the category to list subcategories and the list of subcategories
     */
    public static function getCategoryToListSubsVariables($categoryToListSubsId): array
    {
        $categoryToListSubs = !!$categoryToListSubsId ? Repo::category()->get($categoryToListSubsId) : null;

        $listSubcategories = !!$categoryToListSubs
            ? Repo::category()->getCollector()->filterByParentIds([$categoryToListSubsId])->getMany()
            : null;

        return [$categoryToListSubs, $listSubcategories];
    }

    public static function loadCategoriesByContextId(int $contextId): array
    {
        return Repo::category()
            ->getCollector()
            ->filterByContextIds([$contextId])
            ->getMany()
            ->toArray();
    }

    public static function getParentCategoriesFromCategoryList(array $categories): array
    {
        return collect($categories)
            ->filter(function (Category $category) {
                return !$category->getParentId();
            })
            ->map(function (Category $category) {
                return [
                    'value' => "{$category->getId()}",
                    'label' => $category->getLocalizedTitle()
                ];
            })
            ->sortBy(
                function (array $item) {
                    return $item['label'];
                },
                SORT_NATURAL
            )
            ->values()
            ->toArray();
    }

    /**
     * Retrieves the first subcategories of a submission
     */
    public static function getFirstSubcategories(int $currentPublicationId, ?int $categoryToSearchChildrenOnArticle): ?Category
    {
        $queryBuilder = Repo::category()
            ->getCollector()
            ->filterByPublicationIds([$currentPublicationId]);

        if ($categoryToSearchChildrenOnArticle) {
            $queryBuilder = $queryBuilder->filterByParentIds([$categoryToSearchChildrenOnArticle]);
        }

        $queryBuilder = $queryBuilder->getMany();

        if (!$categoryToSearchChildrenOnArticle) {
            $queryBuilder = $queryBuilder->filter(function (Category $category) {
                return !is_null($category->getParentId());
            });
        }

        return $queryBuilder->first();
    }

    public static function orderCategoriesList(array $categories, array $parentCategoriesOptions): array
    {
        $orderedParentCategoryOptions = [];

        if ($categories) {
            $orderedParentCategoryOptions = array_filter(
                $parentCategoriesOptions,
                fn($catOption) => in_array($catOption['value'], $categories)
            );
        }

        $remainingCategories = array_filter(
            $parentCategoriesOptions,
            fn($parentCat) => !in_array($parentCat['value'], array_column($orderedParentCategoryOptions, 'value'))
        );

        return [...$orderedParentCategoryOptions, ...$remainingCategories];
    }
}
