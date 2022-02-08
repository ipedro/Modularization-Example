import Coordinator
import Inbox
import Shared
import UIKit

extension TabBarFeaturesCoordinator: InboxCoordinatorDelegate {
    func inboxCoordinator(from presentingNavigationController: UINavigationController,
                          messages: [Message]) -> InboxCoordinator
    {
        let inboxCoordinator = InboxCoordinator(
            presenter: presentingNavigationController,
            dependencies: .init(
                messages: messages
            )
        )
        inboxCoordinator.delegate = self
        addChild(inboxCoordinator)
        return inboxCoordinator
    }
}
