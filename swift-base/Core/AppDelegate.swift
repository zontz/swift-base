
import UIKit
import SnapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        setupFlags()
        return true
    }

    private func setupWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: MenuModuleConfigurator().configure())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        let rawValue = Archiver().loadFromUserDefaults(type: Int.self, forKey: SettingKey.theme.rawValue) ?? 0
        let theme = Theme(rawValue: rawValue) ?? .device
        window?.overrideUserInterfaceStyle = theme.getUserInterfaceStyle()
    }

    private func setupFlags() {
        for index in 0..<Resources.flags.count {
            let key = Resources.flags[index].featureFlagName
            Resources.flags[index].isFeatureFlagEnabled = UserDefaults.standard.bool(forKey: key)
        }
    }
}

