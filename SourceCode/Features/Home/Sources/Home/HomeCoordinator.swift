import CoordinatorAPI
import Shared
import UIKit

public protocol HomeCoordinatorDelegate: CoordinatorDismissing {
    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didTapPresentModallyFrom presentingNavigationController: UINavigationController)

    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didTapPushFrom presentingNavigationController: UINavigationController)

    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didTapSwitchToTabFrom presentingNavigationController: UINavigationController)

    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didTapEmbedFrom presentingNavigationController: UINavigationController)

    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didTapAddTabBarFeatureFrom presentingNavigationController: UINavigationController)

    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didTapRemoveTabBarFeatureFrom presentingNavigationController: UINavigationController)

    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didTapOpenNewWindowFrom presentingNavigationController: UINavigationController)
}

public final class HomeCoordinator: BaseFeatureCoordinator {
    public struct Dependencies {
        public var authenticatedUser: AuthenticatedUser

        public init(authenticatedUser: AuthenticatedUser) {
            self.authenticatedUser = authenticatedUser
        }
    }

    let dependencies: Dependencies

    public init(navigationController: UINavigationController,
                dependencies: Dependencies)
    {
        self.dependencies = dependencies
        super.init(navigationController: navigationController)
    }

    override public func willStart() {
        featureViewController.addAction(
            UIAction(title: "New Window") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didTapOpenNewWindowFrom: self.navigationController)
            }
        )
        featureViewController.addSpacer()

        featureViewController.addAction(
            .init(title: "Add Tab Bar Item...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didTapAddTabBarFeatureFrom: self.navigationController)
            }
        )
        featureViewController.addAction(
            .init(title: "Remove Tab Bar Item...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didTapRemoveTabBarFeatureFrom: self.navigationController)
            }
        )

        featureViewController.addSpacer()

        featureViewController.addAction(
            UIAction(title: "Switch To...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didTapSwitchToTabFrom: self.navigationController)
            }
        )
        featureViewController.addAction(
            UIAction(title: "Push...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didTapPushFrom: self.navigationController)
            }
        )
        featureViewController.addAction(
            UIAction(title: "Present...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didTapPresentModallyFrom: self.navigationController)
            }
        )
        featureViewController.addAction(
            UIAction(title: "Embed...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didTapEmbedFrom: self.navigationController)
            }
        )
    }

    public weak var delegate: HomeCoordinatorDelegate? {
        didSet { dismissDelegate = delegate }
    }
}
