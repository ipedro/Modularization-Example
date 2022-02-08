import AlertPresentable
import CoordinatorAPI
import Shared
import UIKit

public protocol SettingsCoordinatorDelegate: AnyObject {}

public struct SettingsDependencies {
    public var authenticatedUser: AuthenticatedUser?
    public var settings: [UIAction]

    public init(authenticatedUser: AuthenticatedUser?,
                settings: [UIAction])
    {
        self.authenticatedUser = authenticatedUser
        self.settings = settings
    }
}

public final class SettingsCoordinator: FeatureCoordinator<SettingsDependencies>, AlertPresentable {
    override public func loadContent() -> ViewController {
        featureViewController.title = "\(dependencies.authenticatedUser?.firstName == .none ? "" : "\(dependencies.authenticatedUser!.firstName)'s ")\(type(of: self))"
        featureViewController.addSpacer()
        featureViewController.addDivider()
        dependencies.settings.forEach { featureViewController.addAction($0) }
        return featureViewController
    }
}
