
import UIKit

protocol MenuViewOutput: AnyObject {
    /// Notify to handle history button click
    func historyButtonDidTap()
    /// Notify to handle game button click
    func gameButtonDidTap()
    /// Notify to handle profile button click
    func profileButtonDidTap()
    /// Notify to handle leader board button click
    func leaderBoardButtonDidTap()
    /// Notify to handle settings button click
    func settingsButtonDidTap()
    /// Notify to handle feature flag button click
    func featureButtonDidTap()
    /// Notify that view will appear
    func viewWillAppear()
}

protocol MenuViewInput: AnyObject {
    /// Update categoryView with new category
    func updateCategoryView(with category: Category)
    /// Update label's with new score and countOfQuestions
    func updateCountAndScore(with count: Int, and score: Int)
    /// Update new game for furher logic
    func updateGame(with game: Game)
}

final class MenuViewController: UIViewController, ModuleTransitionable {

    // MARK: - Properties

    var output: MenuViewOutput

    private let categoryView: CurrentCategoryView
    private let lastGame: LastGameView
    private lazy var category = Category()

    // MARK: - UI

    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor =  UIColor(named: "MainColor")
        label.textAlignment = .center
        label.text = "SwiftED"
        return label
    }()

    private lazy var profileButton = BaseButton(style: .normal, title: "Профиль")
    private lazy var gameButton = BaseButton(style: .normal, title: "Играть")
    private lazy var settingButton = BaseButton(style: .image, image: UIImage(systemName: "gearshape.fill"))
    private lazy var historyButton = BaseButton(style: .normal, title: "История игр")
    private lazy var leaderBoardButton = BaseButton(style: .normal, title: "Таблица игроков")
    private lazy var featureFlagButton = BaseButton(style: .normal, title: "Настроить флаги")
    private lazy var menuVerticalStackView = UIStackView(axis: .vertical, spacing: 10)
    private lazy var gameAndSettingHorizontalStackView = UIStackView(axis: .horizontal,
                                                                     distribution: .fillProportionally,
                                                                     spacing: 5)
    
    private lazy var countOfQuestionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()

    // MARK: - Life Cycle

    init(output: MenuViewOutput,
         categoryView: CurrentCategoryView,
         lastGame: LastGameView) {
        self.output = output
        self.categoryView = categoryView
        self.lastGame = lastGame
        super.init(nibName: nil, bundle: nil)
    }

    convenience init() {
        self.init()
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
        setupBehavior()
        setupConstraints()
    }

    //MARK: - Private methods
    
    private func setup() {
        view.backgroundColor = UIColor(named: "BackgroundColor")

        categoryView.updateCurrentCategory(with: "")

        featureFlagButton.isHidden = !isFeatureFlagMenuEnabled
    }

    private func setupBehavior() {
        profileButton.addTarget(self, action: #selector(profileButtonDidTap), for: .touchUpInside)
        gameButton.addTarget(self, action: #selector(gameButtonDidTap), for: .touchUpInside)
        settingButton.addTarget(self, action: #selector(settingButtonDidTap), for: .touchUpInside)
        historyButton.addTarget(self, action: #selector(historyButtonDidTap), for: .touchUpInside)
        featureFlagButton.addTarget(self, action: #selector(featureFlagButtonDidTap), for: .touchUpInside)
        leaderBoardButton.addTarget(self, action: #selector(leaderBoardButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc
    private func gameButtonDidTap() {
        SoundManager.shared.playSound(sound: .click)
        output.gameButtonDidTap()
    }
    
    @objc
    private func historyButtonDidTap() {
        SoundManager.shared.playSound(sound: .click)
        output.historyButtonDidTap()
    }
    
    @objc
    private func settingButtonDidTap() {
        SoundManager.shared.playSound(sound: .click)
        output.settingsButtonDidTap()
    }

    @objc
    private func featureFlagButtonDidTap() {
        SoundManager.shared.playSound(sound: .click)
        output.featureButtonDidTap()
    }

    @objc
    private func profileButtonDidTap() {
        SoundManager.shared.playSound(sound: .click)
        output.profileButtonDidTap()
    }

    @objc
    private func leaderBoardButtonDidTap() {
        SoundManager.shared.playSound(sound: .click)
        output.leaderBoardButtonDidTap()
    }
}

// MARK: - Layout

extension MenuViewController {
    struct Layout {
        static let menuVerticalStackViewWidthMulti = 0.6

        static let scoreLabelBottomInset = 30

        static let countOfQuestionsLabelBottomInset = 20

        static let categoryViewHeight = 50

        static let settingButtonWidth = 45
    }

    private func setupViews() {
        view.addSubview(menuVerticalStackView)

        menuVerticalStackView.addArrangedSubview(mainLabel)
        menuVerticalStackView.addArrangedSubview(categoryView)
        menuVerticalStackView.addArrangedSubview(lastGame)
        menuVerticalStackView.addArrangedSubview(profileButton)
        menuVerticalStackView.addArrangedSubview(gameAndSettingHorizontalStackView)
        menuVerticalStackView.addArrangedSubview(historyButton)
        menuVerticalStackView.addArrangedSubview(leaderBoardButton)
        menuVerticalStackView.addArrangedSubview(featureFlagButton)

        gameAndSettingHorizontalStackView.addArrangedSubview(gameButton)
        gameAndSettingHorizontalStackView.addArrangedSubview(settingButton)

        view.addSubview(countOfQuestionsLabel)
        view.addSubview(scoreLabel)
    }

    private func setupConstraints() {
        menuVerticalStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Layout.menuVerticalStackViewWidthMulti)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(Layout.scoreLabelBottomInset)
        }

        countOfQuestionsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(scoreLabel).inset(Layout.countOfQuestionsLabelBottomInset)
        }

        categoryView.snp.makeConstraints { make in
            make.height.equalTo(Layout.categoryViewHeight)
        }

        settingButton.snp.makeConstraints { make in
            make.width.equalTo(Layout.settingButtonWidth)
        }
    }
}

// MARK: - MenuViewInput

extension MenuViewController: MenuViewInput {
    func updateCategoryView(with category: Category) {
        categoryView.updateCurrentCategory(with: category.name)
    }

    func updateGame(with game: Game) {
        lastGame.updateLastGame(with: game)
    }

    func updateCountAndScore(with count: Int, and score: Int) {
        let countText = NSMutableAttributedString.setTextWithColor(text: "Количество вопросов в игре: ",
                                                                   textWithColor: String(count),
                                                                   with: UIColor(named: "MainColor"))
        countOfQuestionsLabel.attributedText = countText
        
        let scoreText = NSMutableAttributedString.setTextWithColor(text: "Ваш счет: ",
                                                                   textWithColor: String(score),
                                                                   with: UIColor(named: "MainColor"))
        scoreLabel.attributedText = scoreText
    }
}
