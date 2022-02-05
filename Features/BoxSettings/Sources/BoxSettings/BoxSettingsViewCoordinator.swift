import SharedCode
import UIKit
import Coordinator

public protocol BoxSettingsViewCoordinatorDelegate: FeatureCoordinatorDelegate {
    func boxSettingsViewCoordinator(_ coordindator: CoordinatorProtocol,
                                    didTapMealPlanSelectionFrom navigationController: UINavigationController)
    func boxSettingsViewCoordinator(_ coordindator: CoordinatorProtocol,
                                    didSelectRecipe recipe: Recipe,
                                    from navigationController: UINavigationController)
}

public final class BoxSettingsViewCoordinator: FeatureViewCoordinator {

    public struct Dependencies {
        let recipes: [Recipe]

        public init(recipes: [Recipe]) {
            self.recipes = recipes
        }
    }

    let dependencies: Dependencies

    public init(navigationController: UINavigationController, dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(navigationController: navigationController)
    }


    public weak var delegate: BoxSettingsViewCoordinatorDelegate?

    public override func start() -> UIViewController {
        boxSettingsViewController
    }

    private lazy var boxSettingsViewController: UIViewController = {
        let viewController = FeatureViewController(title: String(describing: type(of: self)))

        dependencies.recipes.forEach { recipe in
            viewController.contentView.addArrangedSubview(
                UIButton(
                    configuration: .bordered(),
                    primaryAction: UIAction(title: recipe.title) { [weak self] _ in
                        guard let self = self else { return }
                        self.delegate?.boxSettingsViewCoordinator(self, didSelectRecipe: recipe, from: self.navigationController)
                    }
                )
            )
        }

        viewController.contentView.addArrangedSubview(
            UIButton(
                configuration: .borderedTinted(),
                primaryAction: UIAction(title: "Select Meal Plan") { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.boxSettingsViewCoordinator(self, didTapMealPlanSelectionFrom: self.navigationController)
                }
            )
        )
        return viewController
    }()
}
