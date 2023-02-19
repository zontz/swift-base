
import UIKit

protocol CategoryViewOutput: AnyObject {}

protocol CategoryViewInput: AnyObject {
    /// Update headerView with new game
    func updateHeaderView(with game: Game)
    /// Reload tableView
    func realoadTable()
}

final class CategoryViewController: UIViewController, ModuleTransitionable {

    // MARK: - Properties

    var output: CategoryViewOutput

    // MARK: - UI
    
    private let headerView: HeaderCategoryScreenView
    private let tableAdapter: CategoryTableAdapter
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = tableAdapter
        tableView.dataSource = tableAdapter
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.systemGray6
        tableView.separatorColor = UIColor.clear
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifire)
        return tableView
    }()

    // MARK: - Life Cycle
    
    init(output: CategoryViewOutput,
         tableAdapter: CategoryTableAdapter,
         headerView: HeaderCategoryScreenView) {
        self.output = output
        self.tableAdapter = tableAdapter
        self.headerView = headerView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

// MARK: - Layout

extension CategoryViewController {
    struct Layout {
        static let headerViewHeight = 100
    }

    private func setupViews() {
        view.addSubview(headerView)
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.right.left.top.equalToSuperview()
            make.height.equalTo(Layout.headerViewHeight)
        }

        tableView.snp.makeConstraints { make in
            make.right.left.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
    }
}

// MARK: CategoryViewInput

extension CategoryViewController: CategoryViewInput {
    func updateHeaderView(with game: Game) {
        headerView.updateHeaderView(with: game)
    }

    func realoadTable() {
        tableView.reloadData()
    }
}



