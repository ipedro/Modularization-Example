import UIKit

public protocol ViewControllerDismissDelegate: AnyObject {
    func viewControllerDidDismiss(_ viewController: UIViewController)
}
