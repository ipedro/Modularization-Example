import UIKit

public final class ToastNotificationWindow: UIWindow {
    private(set) lazy var toastNotificationContainerView: UIView = {
        let sandbox = UIView(frame: bounds)
        sandbox.isUserInteractionEnabled = false
        sandbox.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return sandbox
    }()

    override public init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        super.addSubview(toastNotificationContainerView)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        super.addSubview(toastNotificationContainerView)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        super.addSubview(toastNotificationContainerView)
    }

    override public func addSubview(_ view: UIView) {
        super.addSubview(view)
        bringSubviewToFront(toastNotificationContainerView)
    }
}
