import Coordinator
import CoordinatorAPI
import UIKit

public extension Notification.Name {
    static let coordinatorDidAddChild = Notification.Name("coordinatorDidAddChild")
    static let coordinatorDidRemoveChild = Notification.Name("coordinatorDidRemoveChild")
}

open class FeatureCoordinator<Dependencies>: DebuggableCoordinator<Dependencies, UINavigationController, ViewController> {
    override open var presenter: UINavigationController {
        start().navigationController ?? originalNavigationController
    }

    private var originalNavigationController: UINavigationController { super.presenter }

    override open func loadContent() -> ViewController {
        featureViewController
    }

    open lazy var featureViewController: ViewController = {
        let featureViewController = ViewController(title: self.stringDescription)
        featureViewController.addText(allParentsDescription, .footnote)
        featureViewController.addSpacer()

        featureViewController.dismissHandler = { [weak self] _ in
            guard let self = self else { return }
            if !self.originalNavigationController.viewControllers.isEmpty {
                self.removeFromParent()
            }
        }
        return featureViewController
    }()

    public var allParentsDescription: String {
        ([self] + allParents).reversed().map(\.stringDescription).joined(separator: " > ")
    }

    public var allParents: [CoordinatorProtocol] {
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

public extension CoordinatorProtocol {
    var stringDescription: String { String(describing: type(of: self)) }
}
