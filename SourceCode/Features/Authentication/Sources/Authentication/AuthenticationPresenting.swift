import Coordinator
import CoordinatorAPI
import Shared
import UIKit

public protocol AuthenticationPresentable: CoordinatorProtocol {
    func presentAuthentication(from presenter: UIViewController,
                               animated: Bool,
                               completion: (() -> Void)?)

    func authenticationCoordinator(_ coordinator: CoordinatorProtocol,
                                   didAuthenticatedUser authenticatedUser: AuthenticatedUser)
}

public extension AuthenticationPresentable {
    func presentAuthentication(from presenter: UIViewController,
                               animated: Bool = true,
                               completion: (() -> Void)? = .none)
    {
        let modalNavigationController = NavigationController()
        let coordinator = authenticationCoordinator(from: modalNavigationController)
        modalNavigationController.rootViewController = coordinator.start()
        modalNavigationController.modalPresentationStyle = .formSheet
        presenter.present(
            modalNavigationController,
            animated: animated,
            completion: completion
        )
    }
}

private extension AuthenticationPresentable {
    func authenticationCoordinator(from presenter: UINavigationController) -> AuthenticationCoordinator {
        let authenticationCoordinator = AuthenticationCoordinator(
            presenter: presenter,
            dependencies: ()
        )
        authenticationCoordinator.delegate = self
        addChild(authenticationCoordinator)
        return authenticationCoordinator
    }
}
