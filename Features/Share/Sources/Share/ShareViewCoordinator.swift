import SharedCode

public protocol ShareViewCoordinatorDelegate: FeatureCoordinatorDelegate {}

public final class ShareViewCoordinator: FeatureViewCoordinator {
    public weak var delegate: ShareViewCoordinatorDelegate?
}
