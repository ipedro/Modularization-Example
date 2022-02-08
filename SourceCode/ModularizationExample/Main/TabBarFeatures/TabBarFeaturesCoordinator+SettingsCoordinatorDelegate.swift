import CoordinatorAPI
import Settings
import Shared
import UIKit

extension TabBarFeaturesCoordinator: SettingsCoordinatorDelegate {
    func settingsCoordinator(from presentingNavigationController: UINavigationController) -> SettingsCoordinator {
        let settingsCoordinator = SettingsCoordinator(
            presenter: presentingNavigationController,
            dependencies: .init(
                authenticatedUser: dependencies.authenticatedUser,
                settings: dependencies.settings
            )
        )
        addChild(settingsCoordinator)
        return settingsCoordinator
    }
}
