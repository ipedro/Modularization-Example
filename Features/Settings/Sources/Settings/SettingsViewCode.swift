import UIKit

final class SettingsViewCode: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                greetingLabel,
                button,
                UIView()
            ]
        )
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 20
        stackView.directionalLayoutMargins = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return stackView
    }()

    private(set) lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = .zero
        label.textColor = .secondaryLabel
        return label
    }()

    private(set) lazy var button = UIButton(
        configuration: .filled(),
        primaryAction: .none
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
