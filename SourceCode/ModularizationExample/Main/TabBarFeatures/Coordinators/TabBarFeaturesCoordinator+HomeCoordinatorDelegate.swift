import CoordinatorAPI
import Home
import Shared
import UIKit

extension TabBarFeaturesCoordinator: HomeCoordinatorDelegate {
    func homeCoordinator(from presentingNavigationController: UINavigationController,
                         authenticatedUser: AuthenticatedUser) -> HomeCoordinator
    {
        let homeCoordinator = HomeCoordinator(
            navigationController: presentingNavigationController,
            dependencies: .init(
                authenticatedUser: authenticatedUser
            )
        )
        homeCoordinator.delegate = self
        addChild(homeCoordinator)
        return homeCoordinator
    }

    func homeViewCooordinator(_: HomeCoordinator,
                              didTapOpenNewWindowFrom presentingNavigationController: UINavigationController)
    {
        delegate?.helloFreshCoordinator(self, didTapOpenNewWindowFrom: presentingNavigationController)
    }

    func homeViewCooordinator(_: HomeCoordinator,
                              didTapAddTabBarFeatureFrom presentingNavigationController: UINavigationController)
    {
        delegate?.helloFreshCoordinator(self, didTapAddTabBarFeatureFrom: presentingNavigationController)
    }

    func homeViewCooordinator(_: HomeCoordinator,
                              didTapRemoveTabBarFeatureFrom presentingNavigationController: UINavigationController)
    {
        delegate?.helloFreshCoordinator(self, didTapRemoveTabBarFeatureFrom: presentingNavigationController)
    }

    public func homeViewCooordinator(_ coordinator: HomeCoordinator,
                                     didTapEmbedFrom presentingNavigationController: UINavigationController)
    {
        guard let availableTabBarFeatures = delegate?.availableTabBarFeatures else { return }
        presentActionSheet(
            from: presentingNavigationController,
            title: "Embed...",
            actions: availableTabBarFeatures.compactMap { tabBarFeature in
                .init(title: tabBarFeature.title, style: .default) { [weak self] _ in
                    guard
                        let self = self,
                        let childViewController = self.viewController(for: tabBarFeature, from: presentingNavigationController)
                    else {
                        self?.presentAlert(
                            from: presentingNavigationController,
                            title: "Failed to embed '\(tabBarFeature.title)'"
                        )
                        return
                    }

                    let hostViewController = coordinator.start()
                    hostViewController.addChild(childViewController)

                    hostViewController.addDivider()

                    hostViewController.addText("➡️ Embedded \(tabBarFeature.title)", .callout, .label)

                    let childViews: [UIView] = {
                        guard let scrollView = childViewController.view as? UIScrollView else { return [childViewController.view] }
                        return scrollView.subviews
                    }()

                    childViews.forEach { hostViewController.addArrangedSubview($0) }

                    childViewController.didMove(toParent: hostViewController)
                }
            }
        )
    }

    public func homeViewCooordinator(_: HomeCoordinator,
                                     didTapPushFrom presentingNavigationController: UINavigationController)
    {
        guard let availableTabBarFeatures = delegate?.availableTabBarFeatures else { return }
        presentActionSheet(
            from: presentingNavigationController,
            title: "Push...",
            actions: availableTabBarFeatures.compactMap { tabBarFeature in
                .init(title: tabBarFeature.title, style: .default) { [weak self] _ in
                    guard
                        let self = self,
                        let viewController = self.viewController(for: tabBarFeature, from: presentingNavigationController)
                    else {
                        self?.presentAlert(
                            from: presentingNavigationController,
                            title: "Failed to push '\(tabBarFeature.title)'"
                        )
                        return
                    }
                    presentingNavigationController.pushViewController(viewController, animated: true)
                }
            }
        )
    }

    public func homeViewCooordinator(_: HomeCoordinator,
                                     didTapSwitchToTabFrom presentingNavigationController: UINavigationController)
    {
        presentActionSheet(
            from: presentingNavigationController,
            title: "Switch To...",
            actions: dependencies.tabBarFeatures.enumerated().map { index, tabBarFeature in
                .init(title: tabBarFeature.title, style: .default) { [weak self] _ in
                    self?.tabBarController.selectedIndex = index
                }
            }
        )
    }

    public func homeViewCooordinator(_: HomeCoordinator,
                                     didTapPresentModallyFrom presentingNavigationController: UINavigationController)
    {
        guard let availableTabBarFeatures = delegate?.availableTabBarFeatures else { return }
        presentActionSheet(
            from: presentingNavigationController,
            title: "Present...",
            actions: availableTabBarFeatures.compactMap { tabBarFeature in
                .init(title: tabBarFeature.title, style: .default) { [weak self] _ in
                    guard
                        let self = self,
                        let modalNavigationController = self.navigationController(for: tabBarFeature)
                    else {
                        self?.presentAlert(
                            from: presentingNavigationController,
                            title: "Failed to present modally '\(tabBarFeature.title)'"
                        )
                        return
                    }
                    presentingNavigationController.present(modalNavigationController, animated: true)
                }
            }
        )
    }
}
