
import UIKit

protocol SettingsViewInput: AnyObject {
    /// Update view with new settings
    func updateSettingView(settings: Dictionary<SettingKey, Int>)
    /// Update app with new theme
    func updateTheme(theme: Int)
}

protocol SettingsViewOutput: AnyObject {
    /// Notify that view will appear
    func viewWillAppear()
}

final class SettingsViewController: UIViewController, ModuleTransitionable {

    var output: SettingsViewOutput

    // MARK: - UI

    private let settingView: SettingView

    // MARK: - Life Cycle

    init(output: SettingsViewOutput,settingView: SettingView) {
        self.settingView = settingView
        self.output = output
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
        setupConstraints()
    }

    // MARK: - Private methods

    private func setup() {
        view.backgroundColor = .black.withAlphaComponent(0.3)
    }
}

// MARK: - Layout

extension SettingsViewController {
    struct Layout {
        static let settingViewHeight = 200
    }

    private func setupViews() {
        view.addSubview(settingView)
    }

    private func setupConstraints() {
        settingView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.greaterThanOrEqualTo(Layout.settingViewHeight)
        }
    }
}

// MARK: - SettingsViewInput

extension SettingsViewController: SettingsViewInput {
    func updateTheme(theme: Int) {
        let theme = Theme(rawValue: theme) ?? .device
        view.window?.overrideUserInterfaceStyle = theme.getUserInterfaceStyle()
    }

    func updateSettingView(settings: Dictionary<SettingKey, Int>) {
        settingView.updateSegmentControls(settings: settings)
    }
}
