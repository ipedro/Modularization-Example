import Coordinator
import Shared
import UIKit

public protocol RecipeCoordinatorDelegate: AnyObject {}

public struct RecipeDependencies {
    public var recipe: Recipe

    public init(recipe: Recipe) {
        self.recipe = recipe
    }
}

public final class RecipeCoordinator: FeatureCoordinator<RecipeDependencies> {
    public weak var delegate: RecipeCoordinatorDelegate?

    override public func loadContent() -> ViewController {
        featureViewController.addText(dependencies.recipe.title, .body, .label)
        return featureViewController
    }
}
