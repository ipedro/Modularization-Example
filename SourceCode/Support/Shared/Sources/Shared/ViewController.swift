import Coordinator
import UIKit

open class ViewController: DismissableViewController {
    private lazy var contentView = ContentView()

    public convenience init(title: String? = .none) {
        self.init()
        self.title = title
    }

    override public func loadView() {
        view = contentView
    }

    public func addView(_ view: UIView) {
        contentView.addArrangedSubview(view)
    }

    public func addSpacer() {
        let spacer = UIView()
        spacer.isUserInteractionEnabled = false
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: 20).isActive = true
        addView(spacer)
    }

    public func addDivider() {
        let divider = UIView()
        divider.isUserInteractionEnabled = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        divider.backgroundColor = .tertiaryLabel
        addView(UIView())
        addView(divider)
        addView(UIView())
    }

    public func addText(_ text: String,
                        _ preferredFontStyle: UIFont.TextStyle = .footnote,
                        _ textColor: UIColor = .secondaryLabel)
    {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: preferredFontStyle)
        label.numberOfLines = .zero
        label.text = text
        label.textColor = textColor
        addView(label)
    }

    public func addAction(_ action: UIAction,
                          _ configuration: UIButton.Configuration = .bordered())
    {
        addView(
            UIButton(
                configuration: configuration,
                primaryAction: action
            )
        )
    }
}
