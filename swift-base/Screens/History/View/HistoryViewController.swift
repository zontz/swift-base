
import UIKit

protocol HistoryViewOutput: AnyObject {
    /// Notify that view will dissappear
    func viewWillDisappear()
    /// Notify that view will appear
    func viewWillAppear()
}

protocol HistoryViewInput: AnyObject {
    /// Reload tableView with new games
    func reloadTable(with items: [Game])
}

final class HistoryViewController: UIViewController, ModuleTransitionable {

    // MARK: - Properties

    var output: HistoryViewOutput?

    // MARK: - UI
    
    private let tableAdapter: HistoryTableAdapter
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = tableAdapter
        tableView.dataSource = tableAdapter
        tableView.allowsSelection = false
        tableView.backgroundColor = .systemGray6
        tableView.separatorColor = .clear
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifire)
        return tableView
    }()

    // MARK: - Life Cycle
    
    init(output: HistoryViewOutput,
         tableAdapter: HistoryTableAdapter,
         headerView: HistoryHeaderView) {
        self.output = output
        self.tableAdapter = tableAdapter
        self.tableAdapter.headerView = headerView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        output?.viewWillDisappear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }

    // MARK: - Private methods

    private func setup() {
        view.addSubview(tableView)
    }
}

// MARK: - Layout

extension HistoryViewController {
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - HistoryViewInput

extension HistoryViewController: HistoryViewInput {
    func reloadTable(with items: [Game]) {
        tableAdapter.items = items
        tableView.reloadData()
    }
}
