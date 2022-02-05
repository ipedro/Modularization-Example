import UIKit

import UIKit

public final class ContentView: UIScrollView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.directionalLayoutMargins = .init(top: 2, leading: 20, bottom: 40, trailing: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        alwaysBounceVertical = true
        backgroundColor = .systemBackground
        setupStackView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func addArrangedSubview(_ subview: UIView) {
        stackView.addArrangedSubview(subview)
    }

    public func removeArrangedSubview(_ subview: UIView) {
        stackView.removeArrangedSubview(subview)
    }

    private func setupStackView() {
        addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
}
