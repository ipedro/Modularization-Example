import SharedCode

public protocol InboxViewCoordinatorDelegate: FeatureCoordinatorDelegate {}

public final class InboxViewCoordinator: FeatureViewCoordinator {
    public weak var delegate: InboxViewCoordinatorDelegate?
}
