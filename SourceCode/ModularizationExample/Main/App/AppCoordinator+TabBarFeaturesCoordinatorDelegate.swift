import Authentication
import CoordinatorAPI
import Shared
import UIKit

extension AppCoordinator: TabBarFeaturesCoordinatorDelegate {
    func tabBarFeaturesCoordinator(_: TabBarFeaturesCoordinator,
                                   didTapOpenNewWindowFrom _: UINavigationController)
    {
        delegate?.appCoordinatorDidOpenNewWindow(self)
    }

    var availableTabBarFeatures: [TabBarFeature] {
        delegate?.availableTabBarFeatures ?? []
    }

    func tabBarFeaturesCoordinator(selectedFeature: TabBarFeature?) -> TabBarFeaturesCoordinator {
        let tabBarFeaturesCoordinator = TabBarFeaturesCoordinator(
            presenter: presentingWindow,
            dependencies: .init(
                authenticatedUser: dependencies.authenticatedUser,
                selectedFeature: selectedFeature,
                settings: {
                    var settings: [UIAction] = []

                    if let authenticatedUser = dependencies.authenticatedUser {
                        settings.append(.init(title: "Sign Out...") { [weak self] _ in
                            guard
                                let self = self,
                                let rootViewController = self.presentingWindow.rootViewController
                            else { return }

                            self.presentAlert(
                                from: rootViewController,
                                title: authenticatedUser.fullName,
                                message: "Are you sure you want to sign out?",
                                actions: [
                                    (title: "Sign Out", handler: { [weak self] in
                                        guard let self = self else { return }
                                        self.delegate?.appCoordinatorDidLogout(self)
                                    }),
                                ]
                            )
                        })
                    } else {
                        settings.append(.init(title: "Sign In...") { [weak self] _ in
                            guard let self = self else { return }
                            guard let rootViewController = self.presenter.rootViewController else { return }
                            self.presentAuthentication(from: rootViewController)
                        })
                    }
                    settings.append(.init(title: self.dependencies.shouldShowToasts ? "Showing Toast Messages 👍🏽" : "Showing Toast Messages 👎🏽") { [weak self] _ in
                        guard let self = self else { return }
                        self.delegate?.appCoordinator(self, didChangeToastPreference: !self.dependencies.shouldShowToasts)
                    })
                    return settings
                }(),
                tabBarFeatures: dependencies.tabBarFeatures,
                featuredRecipes: Array(Recipe.allCases.shuffled().prefix(2))
            )
        )
        tabBarFeaturesCoordinator.delegate = self
        addChild(tabBarFeaturesCoordinator)
        return tabBarFeaturesCoordinator
    }

    func tabBarFeaturesCoordinator(_: TabBarFeaturesCoordinator,
                                   didRequestAddTabBarFeatureFrom presentingNavigationController: UINavigationController)
    {
        guard let availableTabBarFeatures = delegate?.availableTabBarFeatures else { return }
        presentActionSheet(
            from: presentingNavigationController,
            title: "Add Tab Bar Item...",
            actions: availableTabBarFeatures.compactMap { tabBarFeature in
                (title: tabBarFeature.title,
                 handler: { [weak self] in
                     guard let self = self else { return }
                     self.delegate?.appCoordinator(self, didAddTabBarFeature: tabBarFeature)
                 })
            }
        )
    }

    func tabBarFeaturesCoordinator(_ coordinator: TabBarFeaturesCoordinator,
                                   didRequestRemoveTabBarFeatureFrom presentingNavigationController: UINavigationController)
    {
        presentActionSheet(
            from: presentingNavigationController,
            title: "Remove Tab Bar Item...",
            actions: coordinator.dependencies.tabBarFeatures.map { tabBarFeature in
                (title: tabBarFeature.title,
                 handler: { [weak self] in
                     guard let self = self else { return }
                     self.delegate?.appCoordinator(self, didRemoveTabBarFeature: tabBarFeature)
                 })
            }
        )
    }

    func tabBarFeaturesCoordinator(_: TabBarFeaturesCoordinator,
                                   didRequestAuthenticationFrom presentingNavigationController: UINavigationController)
    {
        presentAuthentication(from: presentingNavigationController)
    }
}
