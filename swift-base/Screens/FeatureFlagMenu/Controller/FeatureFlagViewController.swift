
import UIKit

final class FeatureFlagMenuViewController: UIViewController {

    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.backgroundColor = .systemGray6
        tableView.separatorColor = .clear
        tableView.register(FeatureFlagMenuTableViewCell.self, forCellReuseIdentifier: FeatureFlagMenuTableViewCell.identifire)
        return tableView
    }()

    // MARK: - Layout

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveFlags()
    }

    // MARK: - Private methods

    private func saveFlags() {
        for flag in Resources.flags {
            UserDefaults.standard.set(flag.isFeatureFlagEnabled, forKey: flag.featureFlagName)
        }
    }
}

// MARK: - Layout

extension FeatureFlagMenuViewController {
    private func setupViews() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension FeatureFlagMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

// MARK: - UITableViewDataSource

extension FeatureFlagMenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Resources.flags.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeatureFlagMenuTableViewCell.identifire, for: indexPath)
                                                                                            as! FeatureFlagMenuTableViewCell
        cell.output = self
        cell.configure(Resources.flags[indexPath.row])
        return cell
    }
}

// MARK: - FeatureFlagMenuTableViewCellOutput

extension FeatureFlagMenuViewController: FeatureFlagMenuTableViewCellOutput {
    func valueDidChange(featureFlage: FeatureFlag) {
        let index = Resources.flags.firstIndex{$0.featureFlagName == featureFlage.featureFlagName}
        Resources.flags[index ?? 0].isFeatureFlagEnabled = featureFlage.isFeatureFlagEnabled
    }
}
