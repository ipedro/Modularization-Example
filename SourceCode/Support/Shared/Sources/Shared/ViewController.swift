import UIKit

open class ViewController: UIViewController {
    open weak var dismissDelegate: ViewControllerDismissDelegate?

    private lazy var contentView = ContentView()

    public convenience init(title: String? = .none,
                            dismissDelegate: ViewControllerDismissDelegate)
    {
        self.init()
        self.title = title
        self.dismissDelegate = dismissDelegate
    }

    override open func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        guard isViewLoaded, parent == .none else { return }
        dismissDelegate?.viewControllerDidDismiss(self)
    }

    override public func loadView() {
        view = contentView
    }

    public func addAction(_ action: UIAction) {
        addArrangedSubview(
            UIButton(
                configuration: .borderedTinted(),
                primaryAction: action
            )
        )
    }

    public func addArrangedSubview(_ subview: UIView) {
        contentView.addArrangedSubview(subview)
    }

    public func addSpacer() {
        let spacer = UIView()
        spacer.isUserInteractionEnabled = false
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: 20).isActive = true
        addArrangedSubview(spacer)
    }

    public func addDivider() {
        let divider = UIView()
        divider.isUserInteractionEnabled = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        divider.backgroundColor = .tertiaryLabel
        addArrangedSubview(UIView())
        addArrangedSubview(divider)
        addArrangedSubview(UIView())
    }

    public func addText(_ text: String, _ preferredFontStyle: UIFont.TextStyle = .footnote, _ textColor: UIColor = .secondaryLabel) {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: preferredFontStyle)
        label.numberOfLines = .zero
        label.text = text
        label.textColor = textColor
        addArrangedSubview(label)
    }
}
