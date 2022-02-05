import SharedCode
import Coordinator
import UIKit

public protocol RecipeViewCoordinatorDelegate: FeatureCoordinatorDelegate {}

public final class RecipeViewCoordinator: FeatureViewCoordinator {

    public struct Dependencies {
        let recipe: Recipe

        public init(recipe: Recipe) {
            self.recipe = recipe
        }
    }

    let dependencies: Dependencies

    public init(navigationController: UINavigationController, dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(navigationController: navigationController)
    }

    public weak var delegate: RecipeViewCoordinatorDelegate?

    public override func start() -> UIViewController {
        recipeViewController
    }

    private lazy var recipeViewController = FeatureViewController(title: dependencies.recipe.title)
}
