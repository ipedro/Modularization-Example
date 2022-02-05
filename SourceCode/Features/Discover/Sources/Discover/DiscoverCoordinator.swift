import Shared

public protocol DiscoverCoordinatorDelegate: CoordinatorDismissing {}

public final class DiscoverCoordinator: BaseFeatureCoordinator {
    public weak var delegate: DiscoverCoordinatorDelegate? {
        didSet { dismissDelegate = delegate }
    }
}
