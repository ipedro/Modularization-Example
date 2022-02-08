import Shared

public protocol ShareCoordinatorDelegate: AnyObject {}

public final class ShareCoordinator: FeatureCoordinator<Void> {
    public weak var delegate: ShareCoordinatorDelegate?
}
