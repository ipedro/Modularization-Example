import UIKit

public final class AdaptivePresentationControllerDelegate: NSObject, UIAdaptivePresentationControllerDelegate {
    public typealias Handler = () -> Void

    public typealias ModalPresentationStyleProvider = (UIPresentationController, UITraitCollection) -> UIModalPresentationStyle

    public typealias DismissDecisionProvider = (UIPresentationController) -> Bool

    let dismissHandler: Handler

    let adaptivePresentationStyleProvider: ModalPresentationStyleProvider?

    let shouldDismissProvider: DismissDecisionProvider?

    let dismissAttemptHandler: Handler?

    public init(
        onDismiss dismissHandler: @escaping Handler,
        adaptivePresentationStyle adaptivePresentationStyleProvider: ModalPresentationStyleProvider? = nil,
        shouldDismiss shouldDismissProvider: DismissDecisionProvider? = nil,
        onDismissAttempt dismissAttemptHandler: Handler? = nil
    ) {
        self.dismissHandler = dismissHandler
        self.adaptivePresentationStyleProvider = adaptivePresentationStyleProvider
        self.shouldDismissProvider = shouldDismissProvider
        self.dismissAttemptHandler = dismissAttemptHandler
    }

    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        dismissHandler()
    }

    public func adaptivePresentationStyle(for controller: UIPresentationController,
                                          traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        adaptivePresentationStyleProvider?(controller, traitCollection) ?? .automatic
    }

    public func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        shouldDismissProvider?(presentationController) ?? true
    }

    public func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        dismissAttemptHandler?()
    }
}
