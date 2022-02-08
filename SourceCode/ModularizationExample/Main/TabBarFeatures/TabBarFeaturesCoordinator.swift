import AlertPresentable
import Coordinator
import CoordinatorAPI
import Shared
import UIKit

protocol TabBarFeaturesCoordinatorDelegate: AlertPresentable, TabFeatureProviding {
    func tabBarFeaturesCoordinator(_ coordinator: TabBarFeaturesCoordinator,
                                   didRequestAuthenticationFrom presentingNavigationController: UINavigationController)

    func tabBarFeaturesCoordinator(_ coordinator: TabBarFeaturesCoordinator,
                                   didRequestAddTabBarFeatureFrom presentingNavigationController: UINavigationController)

    func tabBarFeaturesCoordinator(_ coordinator: TabBarFeaturesCoordinator,
                                   didRequestRemoveTabBarFeatureFrom presentingNavigationController: UINavigationController)

    func tabBarFeaturesCoordinator(_ coordinator: TabBarFeaturesCoordinator,
                                   didTapOpenNewWindowFrom presentingNavigationController: UINavigationController)
}

struct TabBarFeaturesDependencies {
    var authenticatedUser: AuthenticatedUser?
    var selectedFeature: TabBarFeature?
    var settings: [UIAction]
    var tabBarFeatures: [TabBarFeature]
    var featuredRecipes: [Recipe]
}

final class TabBarFeaturesCoordinator: DebuggableCoordinator<TabBarFeaturesDependencies, UIWindow, UITabBarController>, AlertPresentable {
    weak var delegate: TabBarFeaturesCoordinatorDelegate?

    private(set) lazy var tabBarController = TabBarController(
        viewControllers: dependencies.tabBarFeatures.compactMap {
            navigationController(for: $0)
        }
    )

    var currentTabBarFeature: TabBarFeature {
        dependencies.tabBarFeatures[tabBarController.selectedIndex]
    }

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

    override func start() -> UITabBarController {
        if
            let selectedFeature = dependencies.selectedFeature,
            let selectedIndex = dependencies.tabBarFeatures.firstIndex(of: selectedFeature)
        {
            tabBarController.selectedIndex = selectedIndex
        }
        return tabBarController
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
                        from presenter: UINavigationController) -> UIViewController?
    {
        switch (tabBarFeature, dependencies.authenticatedUser) {
        case (.boxSettings, _):
            return boxSettingsCoordinator(from: presenter).start()
        case (.discover, _):
            return discoverCoordinator(from: presenter).start()
        case (.news, _):
            return newsCoordinator(from: presenter).start()
        case (.settings, _):
            return settingsCoordinator(from: presenter).start()
        case (.share, _):
            return shareCoordinator(from: presenter).start()
        case (.home, .none):
            return .none
        case let (.home, authenticatedUser?):
            return homeCoordinator(from: presenter, authenticatedUser: authenticatedUser).start()
        case (.inbox, .none):
            return .none
        case let (.inbox, authenticatedUser?):
            return inboxCoordinator(from: presenter, messages: authenticatedUser.messages).start()
        case (.myMenu, .none):
            return .none
        case let (.myMenu, authenticatedUser?):
            return myMenuCoordinator(from: presenter, recipes: authenticatedUser.recipes).start()
        }
    }
}
