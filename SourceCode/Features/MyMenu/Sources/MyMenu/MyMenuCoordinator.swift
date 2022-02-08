import CoordinatorAPI
import Shared
import UIKit

public protocol MyMenuCoordinatorDelegate: AnyObject {
    func myMenuCoordinator(_ coordinator: MyMenuCoordinator,
                           didSelectRecipe recipe: Recipe,
                           from presenter: UINavigationController)
}

public struct MyMenuDependencies {
    public var recipes: [Recipe]

    public init(recipes: [Recipe]) {
        self.recipes = recipes
    }
}

public final class MyMenuCoordinator: FeatureCoordinator<MyMenuDependencies> {
    public weak var delegate: MyMenuCoordinatorDelegate?

    override public func loadContent() -> ViewController {
        dependencies.recipes.forEach { recipe in
            featureViewController.addAction(
                UIAction(title: recipe.title) { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.myMenuCoordinator(self, didSelectRecipe: recipe, from: self.presenter)
                }
            )
        }
        return featureViewController
    }
}
