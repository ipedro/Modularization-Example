import Coordinator
import Shared
import UIKit

final class AuthenticationCoordinator: FeatureCoordinator<Void> {
    weak var delegate: AuthenticationPresentable?

    override func loadContent() -> ViewController {
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
        return featureViewController
    }
}
