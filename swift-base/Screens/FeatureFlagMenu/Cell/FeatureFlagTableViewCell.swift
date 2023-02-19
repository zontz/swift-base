
import UIKit

protocol FeatureFlagMenuTableViewCellOutput: AnyObject {
    /// Notify that feature flag changed
    func valueDidChange(featureFlage: FeatureFlag)
}

final class FeatureFlagMenuTableViewCell: UITableViewCell {

    static let identifire = "FeatureFlagTableViewCell"

    weak var output: FeatureFlagMenuTableViewCellOutput?

    var flag = FeatureFlag(featureFlagName: "", featureFlagDescription: "", isFeatureFlagEnabled: false)

    // MARK: - UI

    private lazy var featureLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()

    private lazy var verticalStackView = UIStackView(axis: .vertical, spacing: 10)

    private lazy var switchFeatureIsEnabled: UISwitch = {
        let switcher = UISwitch()
        switcher.addTarget(self, action: #selector(switcherFeatureDidChangeValue), for: .valueChanged)
        return switcher
    }()

    private lazy var separatorView = BaseView(style: .separator)
    
    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setup() {
        backgroundColor = .white
    }

    // MARK: - Public Methods

    /// Configure feature flag
    func configure(_ featureFlag: FeatureFlag) {
        self.flag = featureFlag
        featureLabel.text = featureFlag.featureFlagName + "\n" + featureFlag.featureFlagDescription
        switchFeatureIsEnabled.setOn(featureFlag.isFeatureFlagEnabled, animated: true)  
    }

    // MARK: - Actions

    @objc
    private func switcherFeatureDidChangeValue() {
        SoundManager.shared.playSound(sound: .click)
        flag.isFeatureFlagEnabled = switchFeatureIsEnabled.isOn
        output?.valueDidChange(featureFlage: flag)
    }
}

// MARK: - Layout

extension FeatureFlagMenuTableViewCell {
    struct Layout {
        static let verticalStackViewTopInset = 10
        static let verticalStackViewLeftRightInset = 16
        static let verticalStackViewBottomInset = 5

        static let separatorViewHeight = 1

    }

    private func setupViews() {
        contentView.addSubview(verticalStackView)

        verticalStackView.addArrangedSubview(featureLabel)
        verticalStackView.addArrangedSubview(switchFeatureIsEnabled)
        verticalStackView.addArrangedSubview(separatorView)
    }

    private func setupConstraints() {
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(Layout.separatorViewHeight)
        }

        verticalStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Layout.verticalStackViewLeftRightInset)
            make.bottom.equalToSuperview().inset(Layout.verticalStackViewBottomInset)
            make.top.equalToSuperview().inset(Layout.verticalStackViewTopInset)
        }
    }
}
