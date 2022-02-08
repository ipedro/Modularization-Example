import Shared
import UIKit

final class ToastNotificationViewController: UIViewController {
    private final class ContainerViewCode: UIView {}

    private lazy var viewCode = ContainerViewCode()

    override func loadView() {
        view = viewCode
    }

    private struct AnimationInfo {
        let totalDuration: TimeInterval

        var timeUnit: TimeInterval { totalDuration / 16 }

        var showDelay: TimeInterval { timeUnit * 6 }

        var showDuration: TimeInterval { timeUnit * 6 }

        var hideDuration: TimeInterval { timeUnit * 6 }

        var hideDelay: TimeInterval { timeUnit * 10 }
    }

    func showToastNotification(_ toastNotification: ToastNotification, withDuration duration: TimeInterval) {
        let animationInfo = AnimationInfo(totalDuration: duration)

        let initialTransform = CGAffineTransform(translationX: .zero, y: -100).scaledBy(x: 0.85, y: 0.85)

        let toastNotificationView = ToastNotificationView(toastNotification: toastNotification)
        toastNotificationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toastNotificationView)

        toastNotificationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toastNotificationView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        view.layoutIfNeeded()

        toastNotificationView.alpha = .zero
        toastNotificationView.transform = initialTransform

        UIView.animate(
            withDuration: animationInfo.showDuration,
            delay: animationInfo.showDelay,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 1,
            options: .beginFromCurrentState
        ) {
            toastNotificationView.alpha = 1
            toastNotificationView.transform = .identity

        } completion: { isFinished in
            guard isFinished else { return toastNotificationView.removeFromSuperview() }

            UIView.animate(
                withDuration: animationInfo.hideDuration,
                delay: animationInfo.hideDelay,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: .zero,
                options: .beginFromCurrentState
            ) {
                toastNotificationView.alpha = .zero
                toastNotificationView.transform = initialTransform

            } completion: { _ in
                toastNotificationView.removeFromSuperview()
            }
        }
    }
}
