import AlertPresenting
import Coordinator
import CoordinatorAPI
import Shared
import UIKit

protocol TabBarFeaturesCoordinatorDelegate: AlertPresenting, TabFeatureProviding {
    func helloFreshCoordinator(_ coordinator: TabBarFeaturesCoordinator,
                               didTapLoginFrom presentingNavigationController: UINavigationController)

    func helloFreshCoordinator(_ coordinator: TabBarFeaturesCoordinator,
                               didTapAddTabBarFeatureFrom presentingNavigationController: UINavigationController)

    func helloFreshCoordinator(_ coordinator: TabBarFeaturesCoordinator,
                               didTapRemoveTabBarFeatureFrom presentingNavigationController: UINavigationController)

    func helloFreshCoordinator(_ coordinator: TabBarFeaturesCoordinator,
                               didTapOpenNewWindowFrom presentingNavigationController: UINavigationController)

    func helloFreshCoordinatorDidFinish(_ coordinator: TabBarFeaturesCoordinator)
}

final class TabBarFeaturesCoordinator: BaseVerboseCoordinator<UITabBarController>, AlertPresenting {
    struct Dependencies {
        var authenticatedUser: AuthenticatedUser?
        var tabBarFeatures: [TabBarFeature]
    }

    let dependencies: Dependencies

    weak var delegate: TabBarFeaturesCoordinatorDelegate?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    private(set) lazy var tabBarController = TabBarController(
        viewControllers: dependencies.tabBarFeatures.compactMap {
            navigationController(for: $0)
        }
    )

    enum TabBarFeatureError: Error, LocalizedError {
        case couldNotAdd(TabBarFeature)
        case couldNotRemove(TabBarFeature)

        var errorDescription: String? {
            switch self {
            case let .couldNotAdd(tabBarFeature): return "Could not add '\(tabBarFeature.title)'"
            case let .couldNotRemove(tabBarFeature): return "Could not remove '\(tabBarFeature.title)'"
            }
        }
    }

    func start() -> UITabBarController {
        tabBarController
    }

    func navigationController(for tabBarFeature: TabBarFeature) -> NavigationController? {
        let navigationController = NavigationController()
        guard let viewController = viewController(for: tabBarFeature, from: navigationController) else {
            return .none
        }
        navigationController.tabBarItem = tabBarFeature.tabBarItem
        navigationController.rootViewController = viewController
        return navigationController
    }

    func viewController(for tabBarFeature: TabBarFeature,
                        from presentingNavigationController: UINavigationController) -> UIViewController?
    {
        switch (tabBarFeature, dependencies.authenticatedUser) {
        case (.boxSettings, _):
            return boxSettingsCoordinator(from: presentingNavigationController).start()
        case (.discover, _):
            return discoverCoordinator(from: presentingNavigationController).start()
        case (.news, _):
            return newsCoordinator(from: presentingNavigationController).start()
        case (.settings, _):
            return settingsCoordinator(from: presentingNavigationController).start()
        case (.share, _):
            return shareCoordinator(from: presentingNavigationController).start()
        case (.home, .none):
            return .none
        case let (.home, authenticatedUser?):
            return homeCoordinator(from: presentingNavigationController, authenticatedUser: authenticatedUser).start()
        case (.inbox, .none):
            return .none
        case let (.inbox, authenticatedUser?):
            return inboxCoordinator(from: presentingNavigationController, messages: authenticatedUser.messages).start()
        case (.myMenu, .none):
            return .none
        case let (.myMenu, authenticatedUser?):
            return myMenuCoordinator(from: presentingNavigationController, recipes: authenticatedUser.recipes).start()
        }
    }
}
