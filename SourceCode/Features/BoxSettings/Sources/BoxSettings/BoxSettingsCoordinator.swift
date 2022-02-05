import CoordinatorAPI
import Shared
import UIKit

public protocol BoxSettingsCoordinatorDelegate: CoordinatorDismissing {
    func boxSettingsCoordinator(_ coordindator: BoxSettingsCoordinator,
                                didTapMealPlanSelectionFrom presentingNavigationController: UINavigationController)

    func boxSettingsCoordinator(_ coordindator: BoxSettingsCoordinator,
                                didSelectRecipe recipe: Recipe,
                                from presentingNavigationController: UINavigationController)
}

public final class BoxSettingsCoordinator: BaseFeatureCoordinator {
    public weak var delegate: BoxSettingsCoordinatorDelegate? {
        didSet { dismissDelegate = delegate }
    }

    override public init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)

        featureViewController.addAction(
            UIAction(title: "Select Meal Plan...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.boxSettingsCoordinator(self, didTapMealPlanSelectionFrom: self.navigationController)
            }
        )
    }
}
