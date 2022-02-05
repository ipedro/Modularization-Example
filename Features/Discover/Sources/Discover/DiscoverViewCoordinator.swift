import SharedCode

public protocol DiscoverViewCoordinatorDelegate: FeatureCoordinatorDelegate {}

public final class DiscoverViewCoordinator: FeatureViewCoordinator {
    public weak var delegate: DiscoverViewCoordinatorDelegate?
}
