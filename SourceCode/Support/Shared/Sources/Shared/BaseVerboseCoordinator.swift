import Coordinator
import CoordinatorAPI
import UIKit

public extension Notification.Name {
    static let coordinatorDidAddChild = Notification.Name("kCoordinatorDidAddChild")
    static let coordinatorDidRemoveChild = Notification.Name("kCoordinatorDidRemoveChild")
    static let coordinatorDidRemoveAllChildren = Notification.Name("kCoordinatorDidRemoveAllChildren")
}

open class BaseVerboseCoordinator<StartType>: BaseCoordinator<StartType> {
    override open func didAddChild(_ coordinator: CoordinatorProtocol) {
        NotificationCenter.default.post(name: .coordinatorDidAddChild, object: coordinator)
    }

    override open func didRemoveChild(_ coordinator: CoordinatorProtocol) {
        NotificationCenter.default.post(name: .coordinatorDidRemoveChild, object: coordinator)
    }

    override open func didRemoveAllChildren(_ coordinators: [CoordinatorProtocol]) {
        NotificationCenter.default.post(name: .coordinatorDidRemoveAllChildren, object: coordinators)
    }
}
