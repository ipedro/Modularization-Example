import Coordinator
import Shared
import UIKit

final class AuthenticationCoordinator: BaseFeatureCoordinator {
    weak var delegate: AuthenticationPresenting? {
        didSet { dismissDelegate = delegate }
    }

    override func willStart() {
        featureViewController.addSpacer()
        AuthenticatedUser.allCases.forEach { user in
            featureViewController.addAction(
                .init(title: user.fullName) { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.authenticationCoordinator(self, didAuthenticatedUser: user)
                }
            )
            featureViewController.addDivider()
        }
    }
}
