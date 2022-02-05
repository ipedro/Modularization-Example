import UIKit

struct SettingsViewModel {
    let userName: String?
    let actionTitle: String
    let action: UIAction
    var greeting: String { "👋🏽 Hello \(userName ?? "Guest")" }
}
