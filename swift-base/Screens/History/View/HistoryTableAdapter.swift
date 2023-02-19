import UIKit

protocol HistoryTableAdapterOutput: AnyObject {
    /// Notify that the number of elements has changed
    func gamesDidChange(with games: [Game])
}

class HistoryTableAdapter: NSObject {

    // MARK: - Properties

    var items: [Game] = []
    var headerView = UIView()
    weak var output: HistoryTableAdapterOutput?
}

// MARK: - UITableViewDelegate

extension HistoryTableAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UITableViewDataSource

extension HistoryTableAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            output?.gamesDidChange(with: items)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifire, for: indexPath) as! HistoryTableViewCell
        cell.configure(with: items[indexPath.row])
        return cell
    }
}


