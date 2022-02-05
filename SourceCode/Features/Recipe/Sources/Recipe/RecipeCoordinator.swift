import Coordinator
import Shared
import UIKit

public protocol RecipeCoordinatorDelegate: CoordinatorDismissing {}

public final class RecipeCoordinator: BaseFeatureCoordinator {
    public struct Dependencies {
        let recipe: Recipe

        public init(recipe: Recipe) {
            self.recipe = recipe
        }
    }

    let dependencies: Dependencies

    public weak var delegate: RecipeCoordinatorDelegate? {
        didSet { dismissDelegate = delegate }
    }

    public init(navigationController: UINavigationController,
                dependencies: Dependencies)
    {
        self.dependencies = dependencies
        super.init(navigationController: navigationController)
    }

    override public func willStart() {
        featureViewController.addText(dependencies.recipe.title, .body, .label)
    }
}
