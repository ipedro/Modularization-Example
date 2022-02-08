import Coordinator
import News
import Shared
import UIKit

extension TabBarFeaturesCoordinator: NewsCoordinatorDelegate {
    func newsCoordinator(from presentingNavigationController: UINavigationController) -> NewsCoordinator {
        let newsCoordinator = NewsCoordinator(
            presenter: presentingNavigationController,
            dependencies: ()
        )
        newsCoordinator.delegate = self
        addChild(newsCoordinator)
        return newsCoordinator
    }
}
