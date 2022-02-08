import Coordinator
import UIKit

struct AlertCoordinatorDependencies {
    var actions: [(title: String, handler: () -> Void)]
    var message: String?
    var preferredStyle: UIAlertController.Style
    var title: String?
}

final class AlertCoordinator: Coordinator<AlertCoordinatorDependencies, UIViewController, UIAlertController> {
    weak var delegate: AlertPresentable?

    override func loadContent() -> UIAlertController {
        let alertController = UIAlertController(
            title: dependencies.title,
            message: dependencies.message,
            preferredStyle: dependencies.preferredStyle
        )
        alertController.addAction(
            UIAlertAction(
                title: dependencies.actions.count < 1 ? "Dismiss" : "Cancel",
                style: .cancel,
                handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.removeFromParent()
                }
            )
        )
        dependencies.actions.forEach {
            let (title, handler) = $0
            alertController.addAction(
                .init(
                    title: title,
                    style: .default,
                    handler: { [weak self] _ in
                        guard let self = self else { return }
                        self.removeFromParent()
                        handler()
                    }
                )
            )
        }

        return alertController
    }
}
