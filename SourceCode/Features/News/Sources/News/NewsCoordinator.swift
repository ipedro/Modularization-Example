import Shared

public protocol NewsCoordinatorDelegate: CoordinatorDismissing {}

public final class NewsCoordinator: BaseFeatureCoordinator {
    public weak var delegate: NewsCoordinatorDelegate? {
        didSet { dismissDelegate = delegate }
    }
}
