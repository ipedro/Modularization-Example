import BoxSettings
import CoordinatorAPI
import Shared
import UIKit

extension TabBarFeaturesCoordinator: BoxSettingsCoordinatorDelegate {
    func boxSettingsCoordinator(from presentingNavigationController: UINavigationController) -> BoxSettingsCoordinator {
        let boxSettingsCoordinator = BoxSettingsCoordinator(navigationController: presentingNavigationController)
        boxSettingsCoordinator.delegate = self
        addChild(boxSettingsCoordinator)
        return boxSettingsCoordinator
    }

    public func boxSettingsCoordinator(_: BoxSettingsCoordinator,
                                       didSelectRecipe recipe: Recipe,
                                       from presentingNavigationController: UINavigationController)
    {
        let recipeCoordinator = recipeCoordinator(from: presentingNavigationController, recipe: recipe)
        presentingNavigationController.pushViewController(recipeCoordinator.start(), animated: true)
    }

    public func boxSettingsCoordinator(_: BoxSettingsCoordinator,
                                       didTapMealPlanSelectionFrom presentingNavigationController: UINavigationController)
    {
        delegate?.helloFreshCoordinator(self, didTapLoginFrom: presentingNavigationController)
    }
}
