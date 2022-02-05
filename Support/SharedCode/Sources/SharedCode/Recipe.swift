import UIKit

public enum Recipe: CaseIterable {
    case spaghetti, sushi, salad

    public var title: String {
        switch self {
        case .spaghetti:
            return "Spaghetti"
        case .sushi:
            return "Sushi"
        case .salad:
            return "Salad"
        }
    }
}
