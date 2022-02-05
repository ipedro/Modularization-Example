import Coordinator
import CoordinatorAPI
import Shared
import UIKit

public protocol AuthenticationPresenting: CoordinatorDismissing {
    func presentAuthentication(from presentingNavigationController: UINavigationController,
                               animated: Bool,
                               completion: (() -> Void)?)

    func authenticationCoordinator(_ coordinator: CoordinatorProtocol,
                                   didAuthenticatedUser authenticatedUser: AuthenticatedUser)
}

public extension AuthenticationPresenting {
    func presentAuthentication(from presentingNavigationController: UINavigationController,
                               animated: Bool = true,
                               completion: (() -> Void)? = .none)
    {
        let modalNavigationController = NavigationController()
        let coordinator = authenticationCoordinator(from: modalNavigationController)
        modalNavigationController.rootViewController = coordinator.start()
        presentingNavigationController.present(
            modalNavigationController,
            animated: animated,
            completion: completion
        )
    }
}

private extension AuthenticationPresenting {
    func authenticationCoordinator(from presentingNavigationController: UINavigationController) -> AuthenticationCoordinator {
        let authenticationCoordinator = AuthenticationCoordinator(navigationController: presentingNavigationController)
        authenticationCoordinator.delegate = self
        addChild(authenticationCoordinator)
        return authenticationCoordinator
    }
}
