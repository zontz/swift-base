
import UIKit
import Lottie

final class ScreenInDevelopmentViewController: UIViewController {

    // MARK: - UI

    private lazy var screenInDevelopmentLabel: UILabel = {
        let label = UILabel()
        label.text = "Экран находиться в разработке"
        label.textColor = .orange
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    private lazy var animationView: LottieAnimationView = {
        var animation = LottieAnimationView(configuration: LottieConfiguration(renderingEngine: .automatic))
        animation = .init(name: "NoWorking")
        animation.frame = view.bounds
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.animationSpeed = 0.5
        return animation
    }()

    private lazy var closeButton = BaseButton(style: .normal, title: "Закрыть")
    private lazy var verticalStackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 16)
    private lazy var containerView = BaseView(style: .container)


    // MARK: - Life Cycle

    init() {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupBehavior()
        setup()
    }

    // MARK: - Private methods

    private func setup() {
        view.backgroundColor = .black.withAlphaComponent(0.3)
        animationView.isHidden = false
        animationView.play()
    }

    private func setupBehavior() {
        closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc
    private func closeButtonDidTap() {
        SoundManager.shared.playSound(sound: .click)
        dismiss(animated: true)
    }

    // MARK: - Public Methods

    /// Configure popView
    func configure(isEnabled: Bool) {
        if !isEnabled { return }
        screenInDevelopmentLabel.text = "Экран работает!"
    }
}

// MARK: - Layout

extension ScreenInDevelopmentViewController {

    struct Layout {
        static let containerViewHeightMulti = 0.2
        static let containerViewLeftRightInset = 16

        static let verticalStackViewLeftRightInset = 16
        static let verticalStackViewTopBottomInset = 10

        static let animationViewHeight = 150

        static let closeButtonHeight = 40
    }

    private func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(verticalStackView)

        verticalStackView.addArrangedSubview(screenInDevelopmentLabel)
        verticalStackView.addArrangedSubview(animationView)
        verticalStackView.addArrangedSubview(closeButton)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualToSuperview().multipliedBy(Layout.containerViewHeightMulti)
            make.left.right.equalToSuperview().inset(Layout.containerViewLeftRightInset)
            make.centerX.centerY.equalToSuperview()
        }

        verticalStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Layout.verticalStackViewLeftRightInset)
            make.top.bottom.equalToSuperview().inset(Layout.verticalStackViewTopBottomInset)
        }

        animationView.snp.makeConstraints { make in
            make.height.equalTo(Layout.animationViewHeight)
        }

        closeButton.snp.makeConstraints { make in
            make.height.equalTo(Layout.closeButtonHeight)
        }
    }
}
