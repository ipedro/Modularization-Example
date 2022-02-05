import Foundation

public enum AuthenticatedUser: CaseIterable {
    case johnAppleseed
    case bettyBoop

    public var name: String {
        switch self {
        case .johnAppleseed:
            return "John Appleseed"
        case .bettyBoop:
            return "Betty Boop"
        }
    }

    public var emoji: String {
        switch self {
        case .johnAppleseed:
            return "🧔"
        case .bettyBoop:
            return "👩‍🦳"
        }
    }
}
