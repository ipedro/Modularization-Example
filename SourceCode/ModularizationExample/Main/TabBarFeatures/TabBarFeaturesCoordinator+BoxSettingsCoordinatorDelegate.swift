import BoxSettings
import CoordinatorAPI
import Shared
import UIKit

extension TabBarFeaturesCoordinator: BoxSettingsCoordinatorDelegate {
    func boxSettingsCoordinator(from presentingNavigationController: UINavigationController) -> BoxSettingsCoordinator {
        let boxSettingsCoordinator = BoxSettingsCoordinator(
            presenter: presentingNavigationController,
            dependencies: .init(
                featuredRecipes: dependencies.featuredRecipes
            )
        )
        boxSettingsCoordinator.delegate = self
        addChild(boxSettingsCoordinator)
        return boxSettingsCoordinator
    }

    func boxSettingsCoordinator(_: BoxSettingsCoordinator,
                                didSelectRecipe recipe: Recipe,
                                from presentingNavigationController: UINavigationController)
    {
        let recipeCoordinator = recipeCoordinator(from: presentingNavigationController, recipe: recipe)
        presentingNavigationController.pushViewController(recipeCoordinator.start(), animated: true)
    }

    public func boxSettingsCoordinator(_: BoxSettingsCoordinator,
                                       didTapMealPlanSelectionFrom presentingNavigationController: UINavigationController)
    {
        delegate?.tabBarFeaturesCoordinator(self, didRequestAuthenticationFrom: presentingNavigationController)
    }
}
