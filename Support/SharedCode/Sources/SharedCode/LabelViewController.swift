import UIKit

public final class FeatureViewController: UIViewController {
    public private(set) lazy var contentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label])
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = .zero
        label.textColor = .secondaryLabel
        return label
    }()

    public override var title: String? {
        didSet {
            guard let title = title else {
                label.text = .none
                return
            }
            label.text = "👋🏽 Hi, I am\n\(title)"
        }
    }

    public convenience init(title: String?) {
        self.init()
        self.title = title
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

