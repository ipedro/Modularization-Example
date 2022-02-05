import CoordinatorAPI
import Settings
import Shared
import UIKit

extension TabBarFeaturesCoordinator: SettingsCoordinatorDelegate {
    func settingsCoordinator(from presentingNavigationController: UINavigationController) -> SettingsCoordinator {
        let settingsCoordinator = SettingsCoordinator(
            navigationController: presentingNavigationController,
            dependencies: .init(authenticatedUser: dependencies.authenticatedUser)
        )
        settingsCoordinator.delegate = self
        addChild(settingsCoordinator)
        return settingsCoordinator
    }

    func settingsCoordinator(_: SettingsCoordinator,
                             didTapLoginFrom presentingNavigationController: UINavigationController)
    {
        delegate?.helloFreshCoordinator(self, didTapLoginFrom: presentingNavigationController)
    }

    func settingsCoordinator(_: SettingsCoordinator,
                             didTapLogoutFrom _: UINavigationController)
    {
        delegate?.helloFreshCoordinatorDidFinish(self)
    }
}
