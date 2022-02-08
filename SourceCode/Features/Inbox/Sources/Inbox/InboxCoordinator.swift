import Shared
import UIKit

public protocol InboxCoordinatorDelegate: AnyObject {}

public struct InboxDependencies {
    public var messages: [Message]

    public init(messages: [Message]) {
        self.messages = messages
    }
}

public final class InboxCoordinator: FeatureCoordinator<InboxDependencies> {
    override public func loadContent() -> ViewController {
        dependencies.messages.forEach { message in
            featureViewController.addText("✉️ \"\(message.rawValue)\"", .callout)
            featureViewController.addDivider()
        }
        return featureViewController
    }

    public weak var delegate: InboxCoordinatorDelegate?
}
