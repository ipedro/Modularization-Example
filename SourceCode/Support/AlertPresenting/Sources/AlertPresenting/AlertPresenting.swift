import Coordinator
import CoordinatorAPI
import Shared
import UIKit

public protocol AlertPresenting: CoordinatorProtocol {
    func presentAlert(from presentingViewController: UIViewController,
                      title: String?,
                      message: String?,
                      actions: [UIAlertAction])

    func presentActionSheet(from presentingViewController: UIViewController,
                            title: String?,
                            message: String?,
                            actions: [UIAlertAction])

    func alertCoordinatorDidCancel(_ coordinator: CoordinatorProtocol)
}

public extension AlertPresenting {
    func presentAlert(from presentingViewController: UIViewController,
                      title: String? = .none,
                      message: String? = .none,
                      actions: [UIAlertAction] = [])
    {
        present(
            from: presentingViewController,
            title: title,
            message: message,
            actions: actions,
            preferredStyle: .alert
        )
    }

    func presentActionSheet(from presentingViewController: UIViewController,
                            title: String? = .none,
                            message: String? = .none,
                            actions: [UIAlertAction])
    {
        present(
            from: presentingViewController,
            title: title,
            message: message,
            actions: actions,
            preferredStyle: .actionSheet
        )
    }

    func alertCoordinatorDidCancel(_ coordinator: CoordinatorProtocol) {
        removeChild(coordinator)
    }
}

private extension AlertPresenting {
    func present(from presentingViewController: UIViewController,
                 title: String?,
                 message: String?,
                 actions: [UIAlertAction],
                 preferredStyle: UIAlertController.Style)
    {
        let alertCoordinator = AlertCoordinator(
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
            popoverPresentationController.sourceView = presentingViewController.view
            popoverPresentationController.sourceRect = .init(origin: presentingViewController.view.center, size: CGSize(width: 44, height: 44))
        }

        presentingViewController.present(
            alertViewController,
            animated: true,
            completion: .none
        )
    }
}
