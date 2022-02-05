import Authentication
import CoordinatorAPI
import Shared
import UIKit

extension AppCoordinator: TabBarFeaturesCoordinatorDelegate {
    func helloFreshCoordinator(_: TabBarFeaturesCoordinator,
                               didTapOpenNewWindowFrom _: UINavigationController)
    {
        delegate?.appCoordinatorDidOpenNewWindow(self)
    }

    var availableTabBarFeatures: [TabBarFeature] {
        delegate?.availableTabBarFeatures ?? []
    }

    func helloFreshCoordinator() -> TabBarFeaturesCoordinator {
        let helloFreshCoordinator = TabBarFeaturesCoordinator(
            dependencies: .init(
                authenticatedUser: dependencies.authenticatedUser,
                tabBarFeatures: dependencies.tabBarFeatures
            )
        )
        helloFreshCoordinator.delegate = self
        addChild(helloFreshCoordinator)
        return helloFreshCoordinator
    }

    func helloFreshCoordinator(_: TabBarFeaturesCoordinator,
                               didTapAddTabBarFeatureFrom presentingNavigationController: UINavigationController)
    {
        guard let availableTabBarFeatures = delegate?.availableTabBarFeatures else { return }
        presentActionSheet(
            from: presentingNavigationController,
            title: "Add Tab Bar Item...",
            actions: availableTabBarFeatures.compactMap { tabBarFeature in
                .init(title: tabBarFeature.title, style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.appCoordinator(self, didAddTabBarFeature: tabBarFeature)
                }
            }
        )
    }

    func helloFreshCoordinator(_ coordinator: TabBarFeaturesCoordinator,
                               didTapRemoveTabBarFeatureFrom presentingNavigationController: UINavigationController)
    {
        presentActionSheet(
            from: presentingNavigationController,
            title: "Remove Tab Bar Item...",
            actions: coordinator.dependencies.tabBarFeatures.map { tabBarFeature in
                .init(title: tabBarFeature.title, style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.appCoordinator(self, didRemoveTabBarFeature: tabBarFeature)
                }
            }
        )
    }

    func helloFreshCoordinator(_: TabBarFeaturesCoordinator,
                               didTapLoginFrom presentingNavigationController: UINavigationController)
    {
        presentAuthentication(from: presentingNavigationController)
    }

    func helloFreshCoordinatorDidFinish(_ coordinator: TabBarFeaturesCoordinator) {
        removeChild(coordinator)
        delegate?.appCoordinatorDidLogout(self)
    }
}
