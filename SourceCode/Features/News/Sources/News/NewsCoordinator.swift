import Shared

public protocol NewsCoordinatorDelegate: AnyObject {}

public final class NewsCoordinator: FeatureCoordinator<Void> {
    public weak var delegate: NewsCoordinatorDelegate?
}
