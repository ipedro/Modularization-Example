import Shared
import UIKit

public protocol InboxCoordinatorDelegate: CoordinatorDismissing {}

public final class InboxCoordinator: BaseFeatureCoordinator {
    public struct Dependencies {
        public var messages: [Message]

        public init(messages: [Message]) {
            self.messages = messages
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
        dependencies.messages.forEach { message in
            featureViewController.addText("✉️ \"\(message.rawValue)\"", .callout)
            featureViewController.addDivider()
        }
    }

    public weak var delegate: InboxCoordinatorDelegate? {
        didSet { dismissDelegate = delegate }
    }
}
