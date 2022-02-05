import Authentication
import Coordinator
import Shared
import ToastPresenting
import UIKit

protocol AppCoordinatorDelegate: TabFeatureProviding, AnyObject {
    func appCoordinatorDidLogout(_ coordinator: AppCoordinator)

    func appCoordinator(_ coordinator: AppCoordinator,
                        didAuthenticateUser authenticatedUser: AuthenticatedUser)

    func appCoordinator(_ coordinator: AppCoordinator,
                        didRemoveTabBarFeature tabBarFeature: TabBarFeature)

    func appCoordinator(_ coordinator: AppCoordinator,
                        didAddTabBarFeature tabBarFeature: TabBarFeature)

    func appCoordinatorDidOpenNewWindow(_ coordinator: AppCoordinator)
}

final class AppCoordinator: BaseVerboseCoordinator<UIWindow> {
    struct Dependencies {
        var authenticatedUser: AuthenticatedUser?
        var tabBarFeatures: [TabBarFeature]
        var showToast: Bool
    }

    let window: UIWindow

    weak var delegate: AppCoordinatorDelegate?

    let dependencies: Dependencies

    deinit {
        print("🚨 Stopping AppCoordinator")
    }

    private lazy var toastCoordinator = ToastNotificationCoordinator(
        window: window,
        dependencies: .init(
            notifications: [
                .coordinatorDidAddChild,
                .coordinatorDidRemoveChild,
                .coordinatorDidRemoveAllChildren,
            ]
        )
    )

    init(window: UIWindow,
         dependencies: Dependencies)
    {
        self.window = window
        self.dependencies = dependencies
        super.init(
            children: [
            ]
        )
    }

    @discardableResult
    func start() -> UIWindow {
        if dependencies.showToast {
            addChild(toastCoordinator)
            toastCoordinator.start()
        }

        window.tintColor = .systemGreen
        window.rootViewController = helloFreshCoordinator().start()
        window.makeKeyAndVisible()
        return window
    }
}
