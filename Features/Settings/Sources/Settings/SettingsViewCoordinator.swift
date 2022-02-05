import SharedCode
import UIKit
import Coordinator

public protocol SettingsViewCoordinatorDelegate: FeatureCoordinatorDelegate {
    func settingsViewCoordinator(_ coordinator: CoordinatorProtocol,
                                 didTapLoginFrom navigationController: UINavigationController)

    func settingsViewCoordinator(_ coordinator: CoordinatorProtocol,
                                 didTapLogoutFrom navigationController: UINavigationController)
}

public final class SettingsViewCoordinator: FeatureViewCoordinator {
    public struct Dependencies {
        public var authenticatedUser: AuthenticatedUser?
        public var tabBarFeatures: [TabBarFeature]

        public init(
            authenticatedUser: AuthenticatedUser?,
            tabBarFeatures: [TabBarFeature]
        ) {
            self.authenticatedUser = authenticatedUser
            self.tabBarFeatures = tabBarFeatures
        }
    }

    let dependencies: Dependencies

    public init(
        navigationController: UINavigationController,
        dependencies: Dependencies
    ) {
        self.dependencies = dependencies
        super.init(navigationController: navigationController)
    }

    public override func start() -> UIViewController {
        settingsViewController
    }

    public weak var delegate: SettingsViewCoordinatorDelegate?

    private lazy var settingsViewController: SettingsViewController = {
        let settingsViewController = SettingsViewController()
        settingsViewController.viewModel = {
            guard let authenticatedUser = dependencies.authenticatedUser else {
                return SettingsViewModel(
                    userName: nil,
                    actionTitle: "Login",
                    action: UIAction() { [weak self] _ in
                        guard let self = self else { return }
                        self.delegate?.settingsViewCoordinator(self, didTapLoginFrom: self.navigationController)
                    }
                )
            }
            return SettingsViewModel(
                userName: dependencies.authenticatedUser?.name,
                actionTitle: "Logout",
                action: UIAction() { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.settingsViewCoordinator(self, didTapLogoutFrom: self.navigationController)
                }
            )
        }()
        return settingsViewController
    }()
}
