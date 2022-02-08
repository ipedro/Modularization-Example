import CoordinatorAPI
import Shared
import UIKit

public protocol HomeCoordinatorDelegate: AnyObject {
    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didTapPresentModallyFrom presenter: UINavigationController)

    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didTapPushFrom presenter: UINavigationController)

    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didTapSwitchToTabFrom presenter: UINavigationController)

    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didTapEmbedFrom presenter: UINavigationController)

    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didRequestAddTabBarFeatureFrom presenter: UINavigationController)

    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didRequestRemoveTabBarFeatureFrom presenter: UINavigationController)

    func homeViewCooordinator(_ coordinator: HomeCoordinator,
                              didTapOpenNewWindowFrom presenter: UINavigationController)
}

public struct HomeDependencies {
    public var authenticatedUser: AuthenticatedUser

    public init(authenticatedUser: AuthenticatedUser) {
        self.authenticatedUser = authenticatedUser
    }
}

public final class HomeCoordinator: FeatureCoordinator<HomeDependencies> {
    public weak var delegate: HomeCoordinatorDelegate?

    override public func loadContent() -> ViewController {
        featureViewController.addAction(
            UIAction(title: "New Window") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didTapOpenNewWindowFrom: self.presentingNavigationController)
            }
        )

        featureViewController.addSpacer()

        featureViewController.addAction(
            .init(title: "Add Tab Bar Item...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didRequestAddTabBarFeatureFrom: self.presentingNavigationController)
            }
        )
        featureViewController.addAction(
            .init(title: "Remove Tab Bar Item...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didRequestRemoveTabBarFeatureFrom: self.presentingNavigationController)
            }
        )

        featureViewController.addSpacer()

        featureViewController.addAction(
            UIAction(title: "Switch To...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didTapSwitchToTabFrom: self.presentingNavigationController)
            }
        )
        featureViewController.addAction(
            UIAction(title: "Push...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didTapPushFrom: self.presentingNavigationController)
            }
        )
        featureViewController.addAction(
            UIAction(title: "Present...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didTapPresentModallyFrom: self.presentingNavigationController)
            }
        )
        featureViewController.addAction(
            UIAction(title: "Embed...") { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.homeViewCooordinator(self, didTapEmbedFrom: self.presentingNavigationController)
            }
        )

        return featureViewController
    }
}
