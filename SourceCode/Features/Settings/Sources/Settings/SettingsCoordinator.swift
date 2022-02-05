import AlertPresenting
import CoordinatorAPI
import Shared
import UIKit

public protocol SettingsCoordinatorDelegate: CoordinatorDismissing {
    func settingsCoordinator(_ coordinator: SettingsCoordinator,
                             didTapLoginFrom presentingNavigationController: UINavigationController)

    func settingsCoordinator(_ coordinator: SettingsCoordinator,
                             didTapLogoutFrom presentingNavigationController: UINavigationController)
}

public final class SettingsCoordinator: BaseFeatureCoordinator, AlertPresenting {
    public struct Dependencies {
        public var authenticatedUser: AuthenticatedUser?

        public init(authenticatedUser: AuthenticatedUser?) {
            self.authenticatedUser = authenticatedUser
        }
    }

    let dependencies: Dependencies

    public weak var delegate: SettingsCoordinatorDelegate? {
        didSet { dismissDelegate = delegate }
    }

    public init(navigationController: UINavigationController,
                dependencies: Dependencies)
    {
        self.dependencies = dependencies
        super.init(navigationController: navigationController)
    }

    override public func willStart() {
        featureViewController.title = "\(dependencies.authenticatedUser?.firstName == .none ? "" : "\(dependencies.authenticatedUser!.firstName)'s ")\(type(of: self))"
        guard let authenticatedUser = dependencies.authenticatedUser else {
            return featureViewController.addAction(
                .init(title: "Sign In...") { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.settingsCoordinator(self, didTapLoginFrom: self.navigationController)
                }
            )
        }

        featureViewController.addAction(
            .init(title: "Sign Out...") { [weak self] _ in
                guard let self = self else { return }

                self.presentAlert(
                    from: self.navigationController,
                    title: "Sign out from \(authenticatedUser.firstName)'s profile?",
                    message: "\(self.allParentsDescription) > AlertCoordinator",
                    actions: [
                        .init(title: "Sign Out", style: .default) { [weak self] _ in
                            guard let self = self else { return }
                            self.delegate?.settingsCoordinator(self, didTapLogoutFrom: self.navigationController)
                        },
                    ]
                )
            }
        )
    }
}
