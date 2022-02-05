import UIKit

public final class TabBarController: UITabBarController {
    public convenience init(viewControllers: [UIViewController]) {
        self.init()
        self.viewControllers = viewControllers
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
    }
}
