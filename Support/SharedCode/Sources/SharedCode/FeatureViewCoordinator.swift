import UIKit
import Coordinator

public protocol FeatureCoordinatorDelegate: AnyObject {
    func coordinator(_ coordinator: CoordinatorProtocol,
                     didFinishIn navigationController: UINavigationController)
}

open class FeatureViewCoordinator: ViewCoordinator {
    public let navigationController: UINavigationController

    private lazy var fallbackViewController = FeatureViewController(title: String(describing: type(of: self)))

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    open func start() -> UIViewController {
        fallbackViewController
    }
}
