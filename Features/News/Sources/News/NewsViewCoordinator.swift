import SharedCode

public protocol NewsViewCoordinatorDelegate: FeatureCoordinatorDelegate {}

public final class NewsViewCoordinator: FeatureViewCoordinator {
    public weak var delegate: NewsViewCoordinatorDelegate?
}
