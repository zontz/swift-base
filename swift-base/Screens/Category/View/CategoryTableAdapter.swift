import UIKit

protocol CategoryTableAdapterOutput: AnyObject {
    /// Notify to handle category button click
    func categoryButtonDidTap(with category: Category)
}

class CategoryTableAdapter: NSObject {

    // MARK: - Properties

    var items = Resources.themes
    weak var output: CategoryTableAdapterOutput?

}

// MARK: - UITableViewDataSource

extension CategoryTableAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].arrays.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].key
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifire, for: indexPath) as! CategoryTableViewCell
        cell.output = self
        
        let array = items[indexPath.section].arrays
        let categorys = JSONLoader().loadCategorys(filenames: array[indexPath.row])
        cell.configure(with: categorys)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CategoryTableAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: - CategoryTableViewCellOutput

extension CategoryTableAdapter: CategoryTableViewCellOutput {
    func categoryButtonDidTap(_ category: Category) {
        output?.categoryButtonDidTap(with: category)
    }
}
