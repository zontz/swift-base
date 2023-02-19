
import UIKit

protocol PopUpViewOutput: AnyObject {
    /// Notify close button click
    func closeButtonDidTap()
}

final class PopUpViewController: UIViewController {
    
    weak var output: PopUpViewOutput?

    // MARK: - UI

    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Theory"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    private lazy var closeButton = BaseButton(style: .normal, title: "Закрыть")
    private lazy var verticalStackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 16)
    private lazy var containerView = BaseView(style: .container)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
        setupBehavior()
        setupConstraints()
    }
    
    init(output: PopUpViewOutput?, mainText: String, secondText: String, closeButtonText: String) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        mainLabel.text = mainText
        textLabel.text = secondText
        closeButton.setTitle(closeButtonText, for: .normal)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods

    private func setup() {
        view.backgroundColor = .black.withAlphaComponent(0.3)
    }

    private func setupBehavior() {
        closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
    }

    //MARK: - Action
    
    @objc
    private func closeButtonDidTap() {
        SoundManager.shared.playSound(sound: .click)
        dismiss(animated: true)
        if closeButton.titleLabel?.text == "Выйти в главное меню" {
            output?.closeButtonDidTap()
        }
    }
}

// MARK: - Layout

extension PopUpViewController {

    struct Layout {
        static let containerHeightMuilti = 0.2
        static let containerLeftRightInset = 16

        static let verticalStackViewLeftRightInset = 16

        static let closeButtonHeight = 40
    }

    private func setupViews() {
        view.addSubview(containerView)

        containerView.addSubview(verticalStackView)

        verticalStackView.addArrangedSubview(mainLabel)
        verticalStackView.addArrangedSubview(textLabel)
        verticalStackView.addArrangedSubview(closeButton)
    }

    private func setupConstraints() {

        containerView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualToSuperview().multipliedBy(Layout.containerHeightMuilti)
            make.left.right.equalToSuperview().inset(Layout.containerLeftRightInset)
            make.centerX.centerY.equalToSuperview()
        }

        verticalStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Layout.verticalStackViewLeftRightInset)
            make.top.bottom.equalToSuperview().inset(16)
        }

        closeButton.snp.makeConstraints { make in
            make.height.equalTo(Layout.closeButtonHeight)
        }
    }
}
