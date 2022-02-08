import CoordinatorAPI
import Shared
import UIKit

public protocol BoxSettingsCoordinatorDelegate: AnyObject {
    func boxSettingsCoordinator(_ coordindator: BoxSettingsCoordinator,
                                didTapMealPlanSelectionFrom presenter: UINavigationController)

    func boxSettingsCoordinator(_ coordinator: BoxSettingsCoordinator,
                                didSelectRecipe recipe: Recipe,
                                from presenter: UINavigationController)
}

public struct BoxSettingsDependencies {
    public var featuredRecipes: [Recipe]

    public init(featuredRecipes: [Recipe]) {
        self.featuredRecipes = featuredRecipes
    }
}

public final class BoxSettingsCoordinator: FeatureCoordinator<BoxSettingsDependencies> {
    public weak var delegate: BoxSettingsCoordinatorDelegate?

    override public func loadContent() -> ViewController {
        featureViewController.addAction(
            UIAction(title: "Select Meal Plan...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.boxSettingsCoordinator(self, didTapMealPlanSelectionFrom: self.presentingNavigationController)
            }
        )

        featureViewController.addDivider()

        featureViewController.addText("Featured Recipes")

        for recipe in dependencies.featuredRecipes {
            featureViewController.addAction(
                UIAction(title: recipe.title) { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.boxSettingsCoordinator(self, didSelectRecipe: recipe, from: self.presentingNavigationController)
                }
            )
        }

        return featureViewController
    }
}
