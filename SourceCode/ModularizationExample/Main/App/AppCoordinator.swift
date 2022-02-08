import Authentication
import Coordinator
import CoordinatorAPI
import Shared
import ToastPresenting
import UIKit

protocol AppCoordinatorDelegate: TabFeatureProviding, AnyObject {
    func appCoordinatorDidLogout(_ coordinator: AppCoordinator)

    func appCoordinator(_ coordinator: AppCoordinator,
                        didChangeToastPreference shouldShowToasts: Bool)

    func appCoordinator(_ coordinator: AppCoordinator,
                        didAuthenticateUser authenticatedUser: AuthenticatedUser)

    func appCoordinator(_ coordinator: AppCoordinator,
                        didRemoveTabBarFeature tabBarFeature: TabBarFeature)

    func appCoordinator(_ coordinator: AppCoordinator,
                        didAddTabBarFeature tabBarFeature: TabBarFeature)

    func appCoordinatorDidOpenNewWindow(_ coordinator: AppCoordinator)
}

struct AppDependencies {
    var authenticatedUser: AuthenticatedUser?
    var tabBarFeatures: [TabBarFeature]
    var launchTabBarFeature: TabBarFeature?
    var shouldShowToasts: Bool
}

final class AppCoordinator: DebuggableCoordinator<AppDependencies, UIWindow, Void> {
    weak var delegate: AppCoordinatorDelegate?

    var currentTabBarFeature: TabBarFeature? {
        for case let tabBarCoordinator as TabBarFeaturesCoordinator in children {
            return tabBarCoordinator.currentTabBarFeature
        }
        return .none
    }

    override func start() {
        presenter.rootViewController = tabBarFeaturesCoordinator(selectedFeature: dependencies.launchTabBarFeature).start()
        presenter.makeKeyAndVisible()
    }
}
