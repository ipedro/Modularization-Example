import Coordinator
import CoordinatorAPI
import Shared
import UIKit

public protocol AlertPresentable: CoordinatorProtocol {
    func presentAlert(from presenter: UIViewController,
                      title: String?,
                      message: String?,
                      actions: [(title: String, handler: () -> Void)])

    func presentActionSheet(from presenter: UIViewController,
                            title: String?,
                            message: String?,
                            actions: [(title: String, handler: () -> Void)])
}

public extension AlertPresentable {
    func presentAlert(from presenter: UIViewController,
                      title: String? = .none,
                      message: String? = .none,
                      actions: [(title: String, handler: () -> Void)] = [])
    {
        present(
            from: presenter,
            title: title,
            message: message,
            actions: actions,
            preferredStyle: .alert
        )
    }

    func presentActionSheet(from presenter: UIViewController,
                            title: String? = .none,
                            message: String? = .none,
                            actions: [(title: String, handler: () -> Void)])
    {
        present(
            from: presenter,
            title: title,
            message: message,
            actions: actions,
            preferredStyle: .actionSheet
        )
    }
}

private extension AlertPresentable {
    func present(from presenter: UIViewController,
                 title: String?,
                 message: String?,
                 actions: [(title: String, handler: () -> Void)],
                 preferredStyle: UIAlertController.Style)
    {
        let alertCoordinator = AlertCoordinator(
            presenter: presenter,
            dependencies: .init(
                actions: actions,
                message: message,
                preferredStyle: preferredStyle,
                title: title
            )
        )
        alertCoordinator.delegate = self
        addChild(alertCoordinator)

        let alertViewController = alertCoordinator.start()

        if let popoverPresentationController = alertViewController.popoverPresentationController {
            popoverPresentationController.sourceView = presenter.view
            popoverPresentationController.sourceRect = .init(origin: presenter.view.center, size: CGSize(width: 44, height: 44))
        }

        presenter.topViewController.present(
            alertViewController,
            animated: true,
            completion: .none
        )
    }
}
