import UIKit
import Coordinator
import SharedCode
import Authentication

final class AppCoordinator: Coordinator<Void> {
    private let window: UIWindow

    struct Dependencies {
        var authenticatedUser: AuthenticatedUser?
        var customerTabBarFeatures: [TabBarFeature]
        var guestTabBarFeatures: [TabBarFeature]
        var recipes: [Recipe]

        var tabBarFeatures: [TabBarFeature] {
            authenticatedUser == nil ? guestTabBarFeatures : customerTabBarFeatures
        }
    }

    var dependencies: Dependencies

    init(window: UIWindow, dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies
    }

    var helloFreshCoordinator: HelloFreshCoordinator! {
        didSet {
            if let oldValue = oldValue {
                removeChild(oldValue)
            }
            guard let helloFreshCoordinator = helloFreshCoordinator else {
                return
            }
            helloFreshCoordinator.delegate = self
            addChild(helloFreshCoordinator)
        }
    }

    func start() {
        helloFreshCoordinator = HelloFreshCoordinator(
            dependencies: .init(
                authenticatedUser: dependencies.authenticatedUser,
                tabBarFeatures: dependencies.tabBarFeatures,
                recipes: dependencies.recipes
            )
        )
        window.rootViewController = helloFreshCoordinator.start()
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func authenticationCoordinator(_ coordinator: AuthenticationCoordinator,
                                   didFinishWithUser authenticatedUser: AuthenticatedUser?) {
        guard dependencies.authenticatedUser != authenticatedUser else { return }
        dependencies.authenticatedUser = authenticatedUser
        removeAllChildren()
        start()
    }
}

extension AppCoordinator: HelloFreshCoordinatorDelegate {
    func helloFreshCoordinator(_ coordinator: CoordinatorProtocol,
                               didTapLoginFrom navigationController: UINavigationController) {
        let authenticationCoordinator = AuthenticationCoordinator(dependencies: .init())
        authenticationCoordinator.delegate = self
        addChild(authenticationCoordinator)

        navigationController.present(
            authenticationCoordinator.start(),
            animated: true,
            completion: .none
        )
    }

    func helloFreshCoordinatorDidFinish(_ coordinator: HelloFreshCoordinator) {
        dependencies.authenticatedUser = nil
        removeAllChildren()
        start()
    }
}
