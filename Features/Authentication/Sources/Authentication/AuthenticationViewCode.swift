import UIKit

final class AuthenticationViewCode: UIView {

    private lazy var buttonContainerView: UIStackView = {
        let buttonContainer = UIStackView(
            arrangedSubviews: []
        )
        buttonContainer.axis = .vertical
        buttonContainer.spacing = 10
        return buttonContainer
    }()

    private lazy var contentView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                greetingLabel,
                buttonContainerView,
                UIView()
            ]
        )
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.axis = .vertical
        stackView.directionalLayoutMargins = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 20
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

    func addAction(_ action: UIAction) {
        buttonContainerView.addArrangedSubview(
            UIButton(
                configuration: .borderedTinted(),
                primaryAction: action
            )
        )
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(contentView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
