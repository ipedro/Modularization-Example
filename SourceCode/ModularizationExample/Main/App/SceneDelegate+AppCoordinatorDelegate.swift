import Coordinator
import Shared
import UIKit

extension SceneDelegate: AppCoordinatorDelegate {
    func appCoordinatorDidOpenNewWindow(_: AppCoordinator) {
        let userActivity = NSUserActivity(activityType: "new window")
        UIApplication.shared.requestSceneSessionActivation(
            UIApplication.shared.openSessions.first { openSession in
                guard let sessionActivity = openSession.scene?.userActivity,
                      let targetContentIdentifier = sessionActivity.targetContentIdentifier
                else {
                    return false
                }
                return targetContentIdentifier == userActivity.targetContentIdentifier
            },
            userActivity: userActivity,
            options: .none,
            errorHandler: { [weak self] error in
                guard
                    let window = self?.window,
                    let rootViewController = window.rootViewController?.topMostViewController
                else {
                    return
                }
                let alertController = UIAlertController(
                    title: "Sorry",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                alertController.addAction(.init(title: "Dismiss", style: .cancel, handler: .none))
                rootViewController.present(alertController, animated: true, completion: .none)
            }
        )
    }

    func appCoordinator(_: AppCoordinator,
                        didAuthenticateUser authenticatedUser: AuthenticatedUser)
    {
        self.authenticatedUser = authenticatedUser
    }

    func appCoordinatorDidLogout(_: AppCoordinator) {
        authenticatedUser = .none
    }

    func appCoordinator(_: AppCoordinator,
                        didRemoveTabBarFeature tabBarFeature: TabBarFeature)
    {
        guard let index = tabBarFeatures.lastIndex(of: tabBarFeature) else {
            fatalError("Tab feature not found")
        }
        if tabBarFeatures.count == 1 {
            tabBarFeatures = availableTabBarFeatures
        } else {
            tabBarFeatures.remove(at: index)
        }
    }

    func appCoordinator(_: AppCoordinator,
                        didAddTabBarFeature tabBarFeature: TabBarFeature)
    {
        tabBarFeatures.append(tabBarFeature)
    }
}

// MARK: - Private Helpers

private extension UIViewController {
    var topMostViewController: UIViewController {
        presentedViewController ?? self
    }
}
