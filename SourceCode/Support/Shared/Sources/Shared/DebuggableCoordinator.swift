import Coordinator
import CoordinatorAPI
import UIKit

open class DebuggableCoordinator<Dependencies, Presenter: UIResponder, Content>: Coordinator<Dependencies, Presenter, Content> {
    deinit {
        print("👋🏽 Stopping \(type(of: self))")
    }

    private var sourceWindow: UIWindow? {
        switch presenter {
        case let window as UIWindow:
            return window
        case let viewController as UIViewController:
            return viewController.view.window
        default:
            return .none
        }
    }

    override open func addChild(_ coordinator: CoordinatorProtocol) {
        super.addChild(coordinator)
        NotificationCenter.default.post(
            name: .coordinatorDidAddChild,
            object: ToastNotification(
                message: "\(type(of: self)) added \(type(of: coordinator))",
                style: .positive,
                sourceWindow: sourceWindow
            )
        )
    }

    override open func removeChild(_ coordinator: CoordinatorProtocol) {
        super.removeChild(coordinator)
        NotificationCenter.default.post(
            name: .coordinatorDidRemoveChild,
            object: ToastNotification(
                message: "\(type(of: self)) removed \(type(of: coordinator))",
                style: .destructive,
                sourceWindow: sourceWindow
            )
        )
    }
}
