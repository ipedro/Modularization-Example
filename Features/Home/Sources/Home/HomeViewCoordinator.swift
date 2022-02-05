import SharedCode
import Coordinator
import UIKit

public protocol HomeViewCoordinatorDelegate: FeatureCoordinatorDelegate {
    func homeViewCooordinator(_ coordinator: CoordinatorProtocol,
                              didTapShowMenuFrom navigationController: UINavigationController)
}

public final class HomeViewCoordinator: FeatureViewCoordinator {

    public weak var delegate: HomeViewCoordinatorDelegate?

    public override func start() -> UIViewController {
        homeViewController
    }

    private lazy var homeViewController: UIViewController = {
        let viewController = FeatureViewController(title: String(describing: type(of: self)))
        viewController.contentView.addArrangedSubview(
            UIButton(
                configuration: .borderedTinted(),
                primaryAction: UIAction(title: "Show Menu") { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.homeViewCooordinator(self, didTapShowMenuFrom: self.navigationController)
                }
            )
        )
        return viewController
    }()
}
