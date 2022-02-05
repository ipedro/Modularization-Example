import Shared

public protocol ShareCoordinatorDelegate: CoordinatorDismissing {}

public final class ShareCoordinator: BaseFeatureCoordinator {
    public weak var delegate: ShareCoordinatorDelegate? {
        didSet { dismissDelegate = delegate }
    }
}
