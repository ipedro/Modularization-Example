import Coordinator
import CoordinatorAPI
import Shared
import UIKit

public struct ToastNotificationDependencies {
    public var animationDuration: UInt32
    public var notificationNames: [Notification.Name]

    public init(animationDuration: UInt32,
                notifications: [Notification.Name])
    {
        self.animationDuration = animationDuration
        notificationNames = notifications
    }
}

public final class ToastNotificationCoordinator: Coordinator<ToastNotificationDependencies, ToastNotificationWindow, Void> {
    private(set) var presentationQueue: OperationQueue?

    private lazy var toastNotificationViewController = ToastNotificationViewController()

    private var isSubscribed = false {
        didSet {
            guard isSubscribed != oldValue else { return }
            if isSubscribed { subscribe() }
            else { unsubscribe() }
        }
    }

    deinit {
        unsubscribe()
        presentationQueue?.cancelAllOperations()
    }

    override public func start() {
        isSubscribed = true
        presentationQueue = makeOperationQueue()
        toastNotificationViewController.view.frame = presentingWindow.layoutMarginsGuide.layoutFrame
        toastNotificationViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        presentingWindow.toastNotificationContainerView.addSubview(toastNotificationViewController.view)
    }

    public func stop() {
        isSubscribed = false
        presentationQueue?.cancelAllOperations()
        presentationQueue = .none
        toastNotificationViewController.view.removeFromSuperview()
    }

    private func makeOperationQueue() -> OperationQueue {
        let presentationQueue = OperationQueue()
        presentationQueue.maxConcurrentOperationCount = 1
        presentationQueue.qualityOfService = .userInitiated
        presentationQueue.underlyingQueue = .main
        return presentationQueue
    }

    private func unsubscribe() {
        NotificationCenter.default.removeObserver(self)
    }

    private func subscribe() {
        dependencies.notificationNames.forEach { name in
            NotificationCenter.default.addObserver(
                forName: name,
                object: .none,
                queue: .none
            ) { [weak self] notification in
                guard let self = self else { return }

                let toastNotification = ToastNotification(notification, from: self.presentingWindow)

                guard toastNotification.sourceWindow === self.presentingWindow else { return }

                self.presentationQueue?.addBarrierBlock { [weak self] in
                    guard let self = self else { return }

                    DispatchQueue.main.sync {
                        self.toastNotificationViewController.showToastNotification(
                            toastNotification,
                            withDuration: TimeInterval(self.dependencies.animationDuration)
                        )
                    }

                    sleep(self.dependencies.animationDuration)
                }
            }
        }
    }
}

private extension UIView {
    var allSubviews: [UIView] { subviews.flatMap { [$0] + $0.allSubviews } }
}

private extension ToastNotification {
    init(_ notification: Notification, from window: ToastNotificationWindow) {
        switch notification.object {
        case let toastNotification as ToastNotification:
            self = toastNotification
        case let object?:
            self = .init(
                message: "\(notification.name.rawValue): \(String(describing: object))",
                style: .neutral,
                sourceWindow: window
            )
        default:
            self = .init(
                message: notification.name.rawValue,
                style: .neutral,
                sourceWindow: window
            )
        }
    }
}
