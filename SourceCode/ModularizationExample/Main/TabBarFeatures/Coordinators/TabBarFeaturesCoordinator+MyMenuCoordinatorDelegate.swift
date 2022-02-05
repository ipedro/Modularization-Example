import CoordinatorAPI
import MyMenu
import Shared
import UIKit

extension TabBarFeaturesCoordinator: MyMenuCoordinatorDelegate {
    func myMenuCoordinator(from presentingNavigationController: UINavigationController,
                           recipes: [Recipe]) -> MyMenuCoordinator
    {
        let myMenuCoordinator = MyMenuCoordinator(
            navigationController: presentingNavigationController,
            dependencies: .init(recipes: recipes)
        )
        myMenuCoordinator.delegate = self
        addChild(myMenuCoordinator)
        return myMenuCoordinator
    }

    public func myMenuCoordinator(_: MyMenuCoordinator,
                                  didSelectRecipe recipe: Recipe,
                                  from presentingNavigationController: UINavigationController)
    {
        let recipeCoordinator = recipeCoordinator(from: presentingNavigationController, recipe: recipe)
        presentingNavigationController.pushViewController(recipeCoordinator.start(), animated: true)
    }
}
