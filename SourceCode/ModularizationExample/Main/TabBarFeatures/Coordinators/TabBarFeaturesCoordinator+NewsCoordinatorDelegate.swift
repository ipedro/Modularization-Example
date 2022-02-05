import Coordinator
import News
import Shared
import UIKit

extension TabBarFeaturesCoordinator: NewsCoordinatorDelegate {
    func newsCoordinator(from presentingNavigationController: UINavigationController) -> NewsCoordinator {
        let newsCoordinator = NewsCoordinator(navigationController: presentingNavigationController)
        newsCoordinator.delegate = self
        addChild(newsCoordinator)
        return newsCoordinator
    }
}
