import Coordinator
import Discover
import Shared
import UIKit

extension TabBarFeaturesCoordinator: DiscoverCoordinatorDelegate {
    func discoverCoordinator(from presentingNavigationController: UINavigationController) -> DiscoverCoordinator {
        let discoverCoordinator = DiscoverCoordinator(
            presenter: presentingNavigationController,
            dependencies: ()
        )
        discoverCoordinator.delegate = self
        addChild(discoverCoordinator)
        return discoverCoordinator
    }
}
