import Coordinator
import Recipe
import Shared
import UIKit

extension TabBarFeaturesCoordinator: RecipeCoordinatorDelegate {
    func recipeCoordinator(from presentingNavigationController: UINavigationController,
                           recipe: Recipe) -> RecipeCoordinator
    {
        let recipeCoordinator = RecipeCoordinator(
            navigationController: presentingNavigationController,
            dependencies: .init(recipe: recipe)
        )
        recipeCoordinator.delegate = self
        addChild(recipeCoordinator)
        return recipeCoordinator
    }
}
