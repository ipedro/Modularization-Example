import CoordinatorAPI
import Shared
import UIKit

extension TabBarFeaturesCoordinator: CoordinatorDismissing {
    func coordinator(_ coordinator: CoordinatorProtocol,
                     didFinishFrom presentingNavigationController: UINavigationController)
    {
        if !presentingNavigationController.viewControllers.isEmpty {
            removeChild(coordinator)
        }
    }
}
