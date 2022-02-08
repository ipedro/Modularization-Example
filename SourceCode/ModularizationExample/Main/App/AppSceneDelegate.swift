import AlertPresentable
import Coordinator
import Shared
import ToastPresenting
import UIKit

final class AppSceneDelegate: UIResponder {
    var window: ToastNotificationWindow?

    var appCoordinator: AppCoordinator! {
        didSet { appCoordinator.delegate = self }
    }

    private(set) var toastNotificationCoordinator: ToastNotificationCoordinator!

    var authenticatedUser: AuthenticatedUser? = AuthenticatedUser.allCases.randomElement() {
        didSet {
            tabBarFeatures = currentTabBarFeatures
        }
    }

    var currentTabBarFeatures: [TabBarFeature] {
        switch authenticatedUser {
        case .none: return [.boxSettings, .discover, .news, .settings]
        case .some: return [.home, .myMenu, .share, .inbox, .settings]
        }
    }

    var availableTabBarFeatures: [TabBarFeature] {
        TabBarFeature.allCases
    }

    var tabBarFeatures: [TabBarFeature] = [] {
        didSet { restartIfPossible() }
    }

    var shouldShowToasts = true {
        didSet {
            restartIfPossible()
            if shouldShowToasts { toastNotificationCoordinator.start() }
            else { toastNotificationCoordinator.stop() }
        }
    }

    override init() {
        #if DEBUG
            CoordinatorSettings.printLogs = true
        #endif
        super.init()
        tabBarFeatures = currentTabBarFeatures
    }

    private func restartIfPossible() {
        guard let window = window else { return }
        start(in: window, launchTabBarFeature: appCoordinator.currentTabBarFeature)
    }

    private func start(in window: ToastNotificationWindow, launchTabBarFeature: TabBarFeature? = .none) {
        self.window = window

        toastNotificationCoordinator = ToastNotificationCoordinator(
            presenter: window,
            dependencies: .init(
                animationDuration: 1,
                notifications: [
                    .coordinatorDidAddChild,
                    .coordinatorDidRemoveChild,
                ]
            )
        )

        appCoordinator = makeAppCoordinator(
            from: window,
            launchTabBarFeature: launchTabBarFeature
        )

        appCoordinator?.start()

        if shouldShowToasts {
            toastNotificationCoordinator.start()
        }
    }
}

// MARK: - UIWindowSceneDelegate

extension AppSceneDelegate: UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard
            let windowScene = (scene as? UIWindowScene),
            appCoordinator == .none
        else {
            return
        }

        let window = ToastNotificationWindow(windowScene: windowScene)
        window.tintColor = .label

        start(in: window)
    }

    func sceneDidDisconnect(_: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
