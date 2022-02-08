import Shared

public protocol DiscoverCoordinatorDelegate: AnyObject {}

public final class DiscoverCoordinator: FeatureCoordinator<Void> {
    public weak var delegate: DiscoverCoordinatorDelegate?
}
