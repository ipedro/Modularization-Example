import CoordinatorAPI
import Shared
import UIKit

extension AppCoordinator: CoordinatorDismissing {
    func coordinator(_ coordinator: CoordinatorProtocol,
                     didFinishFrom presentingNavigationController: UINavigationController)
    {
        if !presentingNavigationController.viewControllers.isEmpty {
            removeChild(coordinator)
        }
    }
}
