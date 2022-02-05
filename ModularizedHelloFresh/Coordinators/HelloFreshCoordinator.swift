import BoxSettings
import Coordinator
import Discover
import Home
import Inbox
import MyMenu
import Settings
import Share
import SharedCode
import UIKit
import News
import Recipe

public protocol HelloFreshCoordinatorDelegate: AnyObject {
    func helloFreshCoordinator(_ coordinator: CoordinatorProtocol,
                               didTapLoginFrom navigationController: UINavigationController)
    func helloFreshCoordinatorDidFinish(_ coordinator: HelloFreshCoordinator)
}

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

public final class HelloFreshCoordinator: TabBarCoordinator {

    public struct Dependencies {
        public var authenticatedUser: AuthenticatedUser?
        public var tabBarFeatures: [TabBarFeature]
        public var recipes: [Recipe]

        public init(
            authenticatedUser: AuthenticatedUser?,
            tabBarFeatures: [TabBarFeature],
            recipes: [Recipe]
        ) {
            self.authenticatedUser = authenticatedUser
            self.tabBarFeatures = tabBarFeatures
            self.recipes = recipes
        }
    }

    let dependencies: Dependencies

    public weak var delegate: HelloFreshCoordinatorDelegate?

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    private lazy var tabBarController: TabBarController = {
        let tabBarController = TabBarController()
        tabBarController.viewControllers = dependencies.tabBarFeatures.compactMap { feature in
            let navigationController = UINavigationController()
            guard let viewController = viewController(for: feature, with: navigationController) else { return nil }
            navigationController.tabBarItem = feature.tabBarItem
            navigationController.viewControllers = [viewController]
            return navigationController
        }
        return tabBarController
    }()

    public func start() -> UITabBarController {
        tabBarController
    }

    private func viewController(for feature: TabBarFeature, with navigationController: UINavigationController) -> UIViewController? {
        switch feature {
        case .home:
            let homeCoordinator = HomeViewCoordinator(navigationController: navigationController)
            homeCoordinator.delegate = self
            addChild(homeCoordinator)
            return homeCoordinator.start()
        case .myMenu:
            let myMenuCoordinator = MyMenuViewCoordinator(
                navigationController: navigationController,
                dependencies: .init(recipes: dependencies.recipes)
            )
            myMenuCoordinator.delegate = self
            addChild(myMenuCoordinator)
            return myMenuCoordinator.start()
        case .share:
            let shareCoordinator = ShareViewCoordinator(navigationController: navigationController)
            shareCoordinator.delegate = self
            addChild(shareCoordinator)
            return shareCoordinator.start()
        case .inbox:
            let inboxCoordinator = InboxViewCoordinator(navigationController: navigationController)
            inboxCoordinator.delegate = self
            addChild(inboxCoordinator)
            return inboxCoordinator.start()
        case .settings:
            let settingsCoordinator = SettingsViewCoordinator(
                navigationController: navigationController,
                dependencies: .init(
                    authenticatedUser: dependencies.authenticatedUser,
                    tabBarFeatures: dependencies.tabBarFeatures
                )
            )
            settingsCoordinator.delegate = self
            addChild(settingsCoordinator)
            return settingsCoordinator.start()
        case .boxSettings:
            let boxSettingsCoordinator = BoxSettingsViewCoordinator(
                navigationController: navigationController,
                dependencies: .init(
                    recipes: Recipe.allCases
                )
            )
            boxSettingsCoordinator.delegate = self
            addChild(boxSettingsCoordinator)
            return boxSettingsCoordinator.start()
        case .discover:
            let discoverCoordinator = DiscoverViewCoordinator(navigationController: navigationController)
            discoverCoordinator.delegate = self
            addChild(discoverCoordinator)
            return discoverCoordinator.start()
        case .news:
            let newsCoordinator = NewsViewCoordinator(navigationController: navigationController)
            newsCoordinator.delegate = self
            addChild(newsCoordinator)
            return newsCoordinator.start()
        }
    }
}

// MARK: - Features

extension HelloFreshCoordinator: BoxSettingsViewCoordinatorDelegate {
    public func boxSettingsViewCoordinator(_ coordindator: CoordinatorProtocol,
                                           didSelectRecipe recipe: Recipe,
                                           from navigationController: UINavigationController) {
        let recipeCoordinator = RecipeViewCoordinator(
            navigationController: navigationController,
            dependencies: .init(recipe: recipe)
        )
        recipeCoordinator.delegate = self
        addChild(recipeCoordinator)
        navigationController.pushViewController(recipeCoordinator.start(), animated: true)
    }

    public func boxSettingsViewCoordinator(_ coordindator: CoordinatorProtocol,
                                           didTapMealPlanSelectionFrom navigationController: UINavigationController) {
        delegate?.helloFreshCoordinator(self, didTapLoginFrom: navigationController)
    }
}

extension HelloFreshCoordinator: DiscoverViewCoordinatorDelegate {}

extension HelloFreshCoordinator: HomeViewCoordinatorDelegate {
    public func homeViewCooordinator(_ coordinator: CoordinatorProtocol,
                                     didTapShowMenuFrom navigationController: UINavigationController) {
        guard let index = dependencies.tabBarFeatures.firstIndex(of: .myMenu) else {
            let myMenuCoordinator = MyMenuViewCoordinator(
                navigationController: navigationController,
                dependencies: .init(recipes: dependencies.recipes)
            )
            myMenuCoordinator.delegate = self
            addChild(myMenuCoordinator)
            return navigationController.pushViewController(myMenuCoordinator.start(), animated: true)
        }

        tabBarController.selectedIndex = index
    }
}

extension HelloFreshCoordinator: InboxViewCoordinatorDelegate {}

extension HelloFreshCoordinator: MyMenuViewCoordinatorDelegate {
    public func myMenuViewCoordinator(_ coordinator: CoordinatorProtocol,
                                      didSelectRecipe recipe: Recipe,
                                      from navigationController: UINavigationController) {
        let recipeCoordinator = RecipeViewCoordinator(
            navigationController: navigationController,
            dependencies: .init(recipe: recipe)
        )
        recipeCoordinator.delegate = self
        addChild(recipeCoordinator)
        navigationController.pushViewController(recipeCoordinator.start(), animated: true)
    }
}

extension HelloFreshCoordinator: RecipeViewCoordinatorDelegate {
    
}

extension HelloFreshCoordinator: NewsViewCoordinatorDelegate {}

extension HelloFreshCoordinator: SettingsViewCoordinatorDelegate {
    public func settingsViewCoordinator(_ coordinator: CoordinatorProtocol,
                                        didTapLoginFrom navigationController: UINavigationController) {
        delegate?.helloFreshCoordinator(self, didTapLoginFrom: navigationController)
    }

    public func settingsViewCoordinator(_ coordinator: CoordinatorProtocol,
                                        didTapLogoutFrom navigationController: UINavigationController) {
        delegate?.helloFreshCoordinatorDidFinish(self)
    }
}

extension HelloFreshCoordinator: ShareViewCoordinatorDelegate {}

extension HelloFreshCoordinator: FeatureCoordinatorDelegate {
    public func coordinator(_ coordinator: CoordinatorProtocol,
                            didFinishIn navigationController: UINavigationController) {
        removeChild(coordinator)
    }
}
