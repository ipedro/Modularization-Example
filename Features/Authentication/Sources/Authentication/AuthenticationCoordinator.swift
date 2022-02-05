import UIKit
import Coordinator
import SharedCode

public protocol AuthenticationCoordinatorDelegate: AnyObject {
    func authenticationCoordinator(_ coordinator: AuthenticationCoordinator,
                                   didFinishWithUser authenticatedUser: AuthenticatedUser?)
}

public final class AuthenticationCoordinator: NavigationCoordinator {
    public struct Dependencies {
        public init() {}
    }

    private lazy var presentationControllerDelegate = AdaptivePresentationControllerDelegate(
        onDismiss: { [weak self] in
            guard let self = self else { return }
            self.delegate?.authenticationCoordinator(self, didFinishWithUser: .none)
        }
    )

    public weak var delegate: AuthenticationCoordinatorDelegate?

    let dependencies: Dependencies

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public func start() -> UINavigationController {
        navigationController
    }

    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: authenticationViewController)
        navigationController.presentationController?.delegate = presentationControllerDelegate
        return navigationController
    }()

    private lazy var authenticationViewController: AuthenticationViewController = {
        let viewModel = AuthenticationViewModel(
            actions: AuthenticatedUser.allCases.map { user in
                UIAction(
                    title: user.name
//                    image: <#T##UIImage?#>,
//                    identifier: <#T##UIAction.Identifier?#>,
//                    discoverabilityTitle: <#T##String?#>,
//                    attributes: <#T##UIMenuElement.Attributes#>,
//                    state: <#T##UIMenuElement.State#>
                ) { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.authenticationCoordinator(self, didFinishWithUser: user)
                }
            }
        )

        let authenticationViewController = AuthenticationViewController()
        authenticationViewController.viewModel = viewModel
        return authenticationViewController
    }()

}
