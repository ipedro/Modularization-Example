import UIKit

final class AuthenticationViewController: UIViewController {
    private lazy var viewCode = AuthenticationViewCode()

    var viewModel: AuthenticationViewModel!

    override func loadView() {
        view = viewCode
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewCode.greetingLabel.text = viewModel.greeting

        viewModel.actions.forEach { viewCode.addAction($0) }
    }
}
