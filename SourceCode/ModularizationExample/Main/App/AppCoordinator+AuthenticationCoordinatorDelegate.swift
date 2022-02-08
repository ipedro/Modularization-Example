import Authentication
import CoordinatorAPI
import Shared
import UIKit

extension AppCoordinator: AuthenticationPresentable {
    func authenticationCoordinator(_: CoordinatorProtocol,
                                   didAuthenticatedUser authenticatedUser: AuthenticatedUser)
    {
        delegate?.appCoordinator(self, didAuthenticateUser: authenticatedUser)
    }
}
