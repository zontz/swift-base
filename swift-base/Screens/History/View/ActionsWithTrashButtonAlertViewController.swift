
import UIKit

protocol ActionsWithTrashButtonModuleOutput: AnyObject {
    /// Notify that delete all items
    func removeAll()
}

final class ActionsWithTrashButtonAlertViewController: UIAlertController {

    // MARK: - Properties

    weak var output: ActionsWithTrashButtonModuleOutput?

    init(output: ActionsWithTrashButtonModuleOutput,
         title: String = "Вы уверены?",
         message: String = "Рекорды нельзя будет восстановить") {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.message = message
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlert()
    }

    private func setupAlert() {
        let removeAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            self?.output?.removeAll()
        }
        self.addAction(removeAction)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        self.addAction(cancelAction)
    }
}
