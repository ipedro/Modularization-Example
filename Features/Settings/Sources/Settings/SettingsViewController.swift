import UIKit

final class SettingsViewController: UIViewController {
    private lazy var viewCode = SettingsViewCode()

    var viewModel: SettingsViewModel!

    override func loadView() {
        view = viewCode
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewCode.greetingLabel.text = viewModel.greeting
        viewCode.button.setTitle(viewModel.actionTitle, for: .normal)
        viewCode.button.addAction(viewModel.action, for: .touchUpInside)
    }
}
