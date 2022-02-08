import Coordinator
import UIKit

open class NavigationController: DismissableNavigationController {
    public var rootViewController: UIViewController? {
        get { viewControllers.first }
        set {
            if let newValue = newValue { viewControllers = [newValue] }
            else { viewControllers = [] }
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2

        navigationBar.largeTitleTextAttributes = [
            .font: UIFont(name: "AvenirNext-Bold", size: 23)!,
        ]
        navigationBar.titleTextAttributes = [
            .font: UIFont(name: "AvenirNext-Bold", size: 15)!,
        ]
        navigationBar.prefersLargeTitles = true
    }
}
