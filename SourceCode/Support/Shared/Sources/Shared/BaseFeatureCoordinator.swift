import Coordinator
import CoordinatorAPI
import UIKit

open class BaseFeatureCoordinator: BaseVerboseCoordinator<UIViewController>, ViewControllerDismissDelegate {
    public var navigationController: UINavigationController {
        start().navigationController ?? _navigationController
    }

    private let _navigationController: UINavigationController

    open weak var dismissDelegate: CoordinatorDismissing?

    open lazy var featureViewController: ViewController = {
        let featureViewController = ViewController(
            title: stringDescription,
            dismissDelegate: self
        )
        featureViewController.addText(allParentsDescription, .footnote, .tertiaryLabel)
        featureViewController.addSpacer()
        return featureViewController
    }()

    public init(navigationController: UINavigationController) {
        _navigationController = navigationController
    }

    private var isStarted = false {
        willSet {
            if !isStarted {
                willStart()
            }
        }
    }

    open func willStart() {}

    open func start() -> ViewController {
        isStarted = true
        return featureViewController
    }

    public func viewControllerDidDismiss(_: UIViewController) {
        dismissDelegate?.coordinator(self, didFinishFrom: navigationController)
    }
}

// MARK: - Public Helpers

public extension CoordinatorProtocol {
    var allParentsDescription: String {
        ([self] + allParents).reversed().map(\.stringDescription).joined(separator: " > ")
    }

    var allParents: [CoordinatorProtocol] {
        var array: [CoordinatorProtocol] = []
        var coordinator: CoordinatorProtocol? = self

        while coordinator != nil {
            guard let parent = coordinator?.parent else {
                return array
            }
            array.append(parent)
            coordinator = parent
        }
        return array
    }
}

// MARK: - Private Helpers

private extension CoordinatorProtocol {
    var stringDescription: String { String(describing: type(of: self)) }
}
