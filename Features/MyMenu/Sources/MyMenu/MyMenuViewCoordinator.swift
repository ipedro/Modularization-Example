import SharedCode
import Coordinator
import UIKit

public protocol MyMenuViewCoordinatorDelegate: FeatureCoordinatorDelegate {
    func myMenuViewCoordinator(_ coordinator: CoordinatorProtocol,
                               didSelectRecipe recipe: Recipe,
                               from navigationController: UINavigationController)
}

public final class MyMenuViewCoordinator: FeatureViewCoordinator {

    public struct Dependencies {
        let recipes: [Recipe]

        public init(recipes: [Recipe]) {
            self.recipes = recipes
        }
    }

    let dependencies: Dependencies

    public weak var delegate: MyMenuViewCoordinatorDelegate?

    public init(navigationController: UINavigationController, dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(navigationController: navigationController)
    }

    public override func start() -> UIViewController {
        myMenuViewController
    }

    private lazy var myMenuViewController: UIViewController = {
        let viewController = FeatureViewController(title: String(describing: type(of: self)))
        dependencies.recipes.forEach { recipe in
            viewController.contentView.addArrangedSubview(
                UIButton(
                    configuration: .bordered(),
                    primaryAction: UIAction(title: recipe.title) { [weak self] _ in
                        guard let self = self else { return }
                        self.delegate?.myMenuViewCoordinator(self, didSelectRecipe: recipe, from: self.navigationController)
                    }
                )
            )
        }
        return viewController
    }()
}
