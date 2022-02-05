import UIKit

public enum TabBarFeature: String {
    case boxSettings = "Box Settings"
    case discover = "Discover"
    case home = "Home"
    case inbox = "Inbox"
    case myMenu = "My Menu"
    case news = "News"
    case settings = "Settings"
    case share = "Share"

    public var tabBarItem: UITabBarItem { UITabBarItem(title: title, image: image, selectedImage: selectedImage) }

    var title: String { rawValue }

    var image: UIImage { UIImage(systemName: imageName)! }

    var selectedImage: UIImage? {
        guard let selectedImageName = selectedImageName else { return nil }
        return UIImage(systemName: selectedImageName)
    }

    private var imageName: String {
        switch self {
        case .home: return "house.fill"
        case .myMenu: return "menucard.fill"
        case .share: return "square.and.arrow.up.fill"
        case .inbox: return "tray.fill"
        case .settings: return "slider.horizontal.3"
        case .boxSettings: return "shippingbox.fill"
        case .discover: return "magnifyingglass.circle"
        case .news: return "newspaper.fill"
        }
    }

    private var selectedImageName: String? {
        switch self {
        case .home: return "house.fill"
        case .myMenu: return "menucard.fill"
        case .share: return "square.and.arrow.up.fill"
        case .inbox: return "tray.fill"
        case .settings: return "slider.horizontal.3"
        case .boxSettings: return "shippingbox.fill"
        case .discover: return "magnifyingglass.circle"
        case .news: return "newspaper.fill"
        }
    }

}
