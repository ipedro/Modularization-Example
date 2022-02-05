import Coordinator
import CoordinatorAPI
import Shared
import UIKit

public final class ToastNotificationCoordinator: Coordinator<Void> {
    public struct Dependencies {
        public var notificationNames: [Notification.Name]

        public init(notifications: [Notification.Name]) {
            notificationNames = notifications
        }
    }

    let dependencies: Dependencies

    private var operationQueue: OperationQueue? {
        didSet {
            oldValue?.cancelAllOperations()
            unsubscribe()
            subscribe(to: operationQueue)
        }
    }

    private func unsubscribe() {
        dependencies.notificationNames.forEach {
            NotificationCenter.default.removeObserver(self, name: $0, object: .none)
        }
    }

    let window: UIWindow

    public init(window: UIWindow, dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies

        super.init()
    }

    deinit {
        unsubscribe()
        toastContainerView.removeFromSuperview()
        operationQueue?.cancelAllOperations()
        operationQueue = .none
    }

    private lazy var toastContainerView: UIView = {
        let containerView = UIView()
        containerView.isUserInteractionEnabled = false
        window.addSubview(containerView)
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return containerView
    }()

    private func subscribe(to _: OperationQueue?) {
        dependencies.notificationNames.forEach { name in
            NotificationCenter.default.addObserver(
                forName: name,
                object: .none,
                queue: .none
            ) { [weak self] notification in

                print("I was notified", notification)

                self?.operationQueue?.addBarrierBlock { [weak self] in
                    print("I im in a barrier", notification)

                    DispatchQueue.main.sync { [weak self] in
                        guard
                            let self = self,
                            self.window.subviews.contains(self.toastContainerView)
                        else {
                            return
                        }

                        self.window.bringSubviewToFront(self.toastContainerView)

                        let toastView = self.toastView(for: notification)
                        toastView.translatesAutoresizingMaskIntoConstraints = false
                        toastView.alpha = .zero
                        toastView.transform = .init(scaleX: 0.7, y: 0.7)
                        toastView.layer.shouldRasterize = true
                        toastView.layer.rasterizationScale = UIScreen.main.scale

                        self.toastContainerView.transform = .init(translationX: .zero, y: -80)
                        self.toastContainerView.addSubview(toastView)

                        toastView.centerXAnchor.constraint(equalTo: self.window.centerXAnchor).isActive = true
                        toastView.topAnchor.constraint(equalTo: self.window.layoutMarginsGuide.topAnchor).isActive = true

                        UIView.animate(withDuration: 3.5, delay: .zero, options: [.curveLinear, .layoutSubviews]) {
                            toastView.transform = .init(scaleX: 0.75, y: 0.75)
                        }

                        UIView.animate(
                            withDuration: 0.6,
                            delay: 0.2,
                            usingSpringWithDamping: 0.88,
                            initialSpringVelocity: .zero,
                            options: [.beginFromCurrentState, .layoutSubviews]
                        ) {
                            toastView.alpha = 1
                            self.toastContainerView.transform = .identity

                        } completion: { isFinished in
                            guard isFinished else { return toastView.removeFromSuperview() }

                            UIView.animate(
                                withDuration: 1,
                                delay: 2,
                                usingSpringWithDamping: 0.84,
                                initialSpringVelocity: .zero,
                                options: [.beginFromCurrentState, .layoutSubviews]
                            ) {
                                toastView.alpha = .zero
                                self.toastContainerView.transform = .init(translationX: .zero, y: -200)

                            } completion: { _ in
                                toastView.removeFromSuperview()
                            }
                        }
                    }

                    // TODO: make less hacky
                    sleep(3)
                }
            }
        }
    }

    private func toastView(for notification: Notification) -> UIView {
        let button = UIButton(
            configuration: .borderedProminent(),
            primaryAction: .init(
                title: {
                    switch (notification.name, notification.object) {
                    case let (.coordinatorDidAddChild, coordinator as CoordinatorProtocol) where coordinator.parent != nil:
                        return "\(type(of: coordinator.parent!)) added \(type(of: coordinator))"
                    case let (.coordinatorDidAddChild, coordinator as CoordinatorProtocol):
                        return "\(type(of: coordinator)) was added"
                    case let (.coordinatorDidRemoveChild, coordinator as CoordinatorProtocol):
                        return "\(type(of: coordinator)) was removed"
                    case let (.coordinatorDidRemoveAllChildren, coordinators as [CoordinatorProtocol]) where !coordinators.isEmpty:
                        return coordinators.map { String(describing: type(of: $0)) }.joined(separator: ", ") + " were removed"
                    default:
                        return notification.name.rawValue
                    }
                }(),
                handler: { _ in }
            )
        )
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    public func start() {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
        queue.underlyingQueue = .main
        operationQueue = queue
    }
}
