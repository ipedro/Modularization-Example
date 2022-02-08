import UIKit

public struct ToastNotification: Hashable {
    public enum Style: Hashable {
        case neutral, positive, destructive
    }

    public var message: String

    public var style: Style

    public let sourceWindow: UIWindow?

    public init(
        message: String,
        style: Style,
        sourceWindow: UIWindow?
    ) {
        self.message = message
        self.style = style
        self.sourceWindow = sourceWindow
    }
}
