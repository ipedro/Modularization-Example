import Coordinator
import UIKit

final class AlertCoordinator: Coordinator<UIViewController> {
    struct Dependencies {
        var actions: [UIAlertAction]
        var message: String?
        var preferredStyle: UIAlertController.Style
        var title: String?

        init(actions: [UIAlertAction],
             message: String?,
             preferredStyle: UIAlertController.Style,
             title: String?)
        {
            self.actions = actions
            self.message = message
            self.preferredStyle = preferredStyle
            self.title = title
        }
    }

    let dependencies: Dependencies

    weak var delegate: AlertPresenting?

    private lazy var alertController: UIAlertController = {
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
                    self.delegate?.alertCoordinatorDidCancel(self)
                }
            )
        )
        dependencies.actions.forEach { alertController.addAction($0) }
        return alertController
    }()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func start() -> UIViewController {
        alertController
    }
}
