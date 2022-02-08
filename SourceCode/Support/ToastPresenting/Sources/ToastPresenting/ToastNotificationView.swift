import Shared
import UIKit

final class ToastNotificationView: UIView {
    typealias Configuration = UIButton.Configuration

    let toastNotification: ToastNotification

    private lazy var contentView: UIButton = {
        let button = UIButton(
            configuration: toastNotification.viewConfiguration,
            primaryAction: .init(
                title: toastNotification.message,
                handler: { _ in }
            )
        )
        button.transform = .init(scaleX: 0.85, y: 0.85)
        button.layer.rasterizationScale = UIScreen.main.scale
        button.layer.shouldRasterize = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(toastNotification: ToastNotification,
         frame: CGRect = .zero)
    {
        self.toastNotification = toastNotification

        super.init(frame: frame)

        addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: .zero, height: 2)
        layer.shadowOpacity = 0.2
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

// MARK: - Private Helpers

private extension ToastNotification {
    var viewConfiguration: ToastNotificationView.Configuration {
        var configuration: ToastNotificationView.Configuration = .borderedProminent()
        configuration.buttonSize = .mini
        configuration.baseForegroundColor = .systemBackground

        switch style {
        case .neutral:
            configuration.baseBackgroundColor = .systemGray
        case .positive:
            configuration.baseBackgroundColor = .init(
                red: 53 / 255,
                green: 187 / 255,
                blue: 95 / 255,
                alpha: 1
            )
        case .destructive:
            configuration.baseBackgroundColor = .systemRed
        }

        return configuration
    }
}
