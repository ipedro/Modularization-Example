import CoordinatorAPI
import UIKit

public protocol CoordinatorDismissing: CoordinatorProtocol {
    func coordinator(_ coordinator: CoordinatorProtocol,
                     didFinishFrom presentingNavigationController: UINavigationController)
}

public extension CoordinatorDismissing {
    func coordinator(_ coordinator: CoordinatorProtocol,
                     didFinishFrom presentingNavigationController: UINavigationController)
    {
        if !presentingNavigationController.viewControllers.isEmpty {
            removeChild(coordinator)
        }
    }
}
