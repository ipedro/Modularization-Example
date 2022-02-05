import UIKit

open class NavigationController: UINavigationController {
    public weak var dismissDelegate: ViewControllerDismissDelegate?

    public var rootViewController: UIViewController? {
        get { viewControllers.first }
        set {
            if let newValue = newValue {
                viewControllers = [newValue]
            } else {
                viewControllers = []
            }
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

        if let presentationController = presentationController {
            presentationController.delegate = presentationControllerDelegate
        }
    }

    private lazy var presentationControllerDelegate = AdaptivePresentationControllerDelegate(
        onDismiss: { [weak self] in
            guard let self = self else { return }
            self.notifyDismissDelegate()
        }
    )

    private func notifyDismissDelegate() {
        dismissDelegate?.viewControllerDidDismiss(self)

        for case let viewController as ViewController in viewControllers {
            viewController.dismissDelegate?.viewControllerDidDismiss(viewController)
        }
    }
}
