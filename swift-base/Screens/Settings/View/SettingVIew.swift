
import UIKit

protocol SettingViewInput: AnyObject {
    /// Update default selected items
    func updateSegmentControls(settings: Dictionary<SettingKey, Int>)
}

protocol SettingViewOutput: AnyObject {
    /// Notify close button click
    func closeButtonDidTap(settings: Dictionary<SettingKey, Int>)
}

final class SettingView: UIView {

    // MARK: - Properties
    
    weak var output: SettingViewOutput?

    // MARK: - UI
    
    private lazy var soundLabel: UILabel = {
        let label = UILabel()
        label.text = "Звуки в игре:"
        label.textColor = .gray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var soundSegmentControl: UISegmentedControl = {
        let items = ["Включены", "Выключены"]
        let segment = UISegmentedControl(items: items)
        segment.tintColor = .systemGray5
        segment.selectedSegmentTintColor = .white
        return segment
    }()

    private lazy var soundVerticalStackView = UIStackView(axis: .vertical, spacing: 5)

    private lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.text = "Переход после неправильного ответа"
        label.textColor = .gray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    private lazy var hintSegmentControl: UISegmentedControl = {
        let items = ["Да", "Нет"]
        let segment = UISegmentedControl(items: items)
        segment.tintColor = .systemGray5
        segment.selectedSegmentTintColor = .white
        return segment
    }()

    private lazy var hintVerticalStackView = UIStackView(axis: .vertical, spacing: 5)

    private lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Тема:"
        label.textColor = .gray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    private lazy var themeSegmentControl: UISegmentedControl = {
        let items = ["Стандатная", "Светлая", "Темная"]
        let segment = UISegmentedControl(items: items)
        segment.tintColor = .systemGray5
        segment.selectedSegmentTintColor = .white
        return segment
    }()

    private lazy var themeVerticalStackView = UIStackView(axis: .vertical, spacing: 5)
    private lazy var closeButton = BaseButton(style: .normal, title: "Сохранить")
    private lazy var verticalStackView = UIStackView(axis: .vertical, spacing: 10)


    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupViews()
        setupBehavior()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    
    private func setup() {
        layer.cornerRadius = 10
        backgroundColor = .white
    }

    private func setupBehavior() {
        closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc
    private func closeButtonDidTap() {
        SoundManager.shared.playSound(sound: .click)
        var settings: Dictionary<SettingKey,Int> = [:]
        settings[.theme] = themeSegmentControl.selectedSegmentIndex
        settings[.sound] = soundSegmentControl.selectedSegmentIndex
        settings[.hint] = hintSegmentControl.selectedSegmentIndex
        output?.closeButtonDidTap(settings: settings)
    }
}

// MARK: - Layout

extension SettingView {
    struct Layout {
        static let verticalStackViewLeftRightInset = 16
        static let verticalStackViewTopBottomInset = 10

        static let closeButtonHeight = 40
    }

    private func setupViews() {
        addSubview(verticalStackView)

        verticalStackView.addArrangedSubview(soundVerticalStackView)
        verticalStackView.addArrangedSubview(hintVerticalStackView)
        verticalStackView.addArrangedSubview(themeVerticalStackView)
        verticalStackView.addArrangedSubview(closeButton)

        soundVerticalStackView.addArrangedSubview(soundLabel)
        soundVerticalStackView.addArrangedSubview(soundSegmentControl)

        hintVerticalStackView.addArrangedSubview(hintLabel)
        hintVerticalStackView.addArrangedSubview(hintSegmentControl)

        themeVerticalStackView.addArrangedSubview(themeLabel)
        themeVerticalStackView.addArrangedSubview(themeSegmentControl)
    }

    private func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Layout.verticalStackViewLeftRightInset)
            make.top.bottom.equalToSuperview().inset(Layout.verticalStackViewTopBottomInset)
        }

        closeButton.snp.makeConstraints { make in
            make.height.equalTo(Layout.closeButtonHeight)
        }
    }
}

// MARK: - SettingViewInput

extension SettingView: SettingViewInput {
    func updateSegmentControls(settings: Dictionary<SettingKey, Int>) {
        settings.forEach {
            switch $0.key {
                case .sound: soundSegmentControl.selectedSegmentIndex = $0.value
                case .hint: hintSegmentControl.selectedSegmentIndex = $0.value
                case .theme: themeSegmentControl.selectedSegmentIndex = $0.value
            }
        }
    }
}


