import CoordinatorAPI
import Shared
import UIKit

public protocol MyMenuCoordinatorDelegate: CoordinatorDismissing {
    func myMenuCoordinator(_ coordinator: MyMenuCoordinator,
                           didSelectRecipe recipe: Recipe,
                           from presentingNavigationController: UINavigationController)
}

public final class MyMenuCoordinator: BaseFeatureCoordinator {
    public struct Dependencies {
        var recipes: [Recipe]

        public init(recipes: [Recipe]) {
            self.recipes = recipes
        }
    }

    let dependencies: Dependencies

    public weak var delegate: MyMenuCoordinatorDelegate? {
        didSet { dismissDelegate = delegate }
    }

    public init(navigationController: UINavigationController,
                dependencies: Dependencies)
    {
        self.dependencies = dependencies
        super.init(navigationController: navigationController)
    }

    override public func willStart() {
        dependencies.recipes.forEach { recipe in
            featureViewController.addAction(
                UIAction(title: recipe.title) { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.myMenuCoordinator(self, didSelectRecipe: recipe, from: self.navigationController)
                }
            )
        }
    }
}
