import Coordinator
import Share
import Shared
import UIKit

extension TabBarFeaturesCoordinator: ShareCoordinatorDelegate {
    func shareCoordinator(from presentingNavigationController: UINavigationController) -> ShareCoordinator {
        let recipeCoordinator = ShareCoordinator(
            presenter: presentingNavigationController,
            dependencies: ()
        )
        recipeCoordinator.delegate = self
        addChild(recipeCoordinator)
        return recipeCoordinator
    }
}
