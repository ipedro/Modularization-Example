import Foundation

public enum AuthenticatedUser: CaseIterable, Hashable {
    case johnAppleseed
    case bettyBoop

    public var firstName: String {
        switch self {
        case .johnAppleseed: return "John"
        case .bettyBoop: return "Betty"
        }
    }

    public var lastName: String {
        switch self {
        case .johnAppleseed: return "Appleseed"
        case .bettyBoop: return "Boop"
        }
    }

    public var fullName: String { [firstName, lastName].joined(separator: " ") }

    public var recipes: [Recipe] {
        switch self {
        case .johnAppleseed:
            return [.pumpkinSoup, .applePie, .couscous]
        case .bettyBoop:
            return [.couscous, .penne, .chickenMarsala]
        }
    }

    public var messages: [Message] {
        switch self {
        case .johnAppleseed:
            return [.veryImportant]
        case .bettyBoop:
            return [.discount, .veryImportant]
        }
    }
}
