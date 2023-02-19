
import UIKit

protocol HistoryRouterInput {
    func showActionsModule(output: ActionsWithTrashButtonModuleOutput)
}


final class HistoryRouter: HistoryRouterInput {
    weak var view: ModuleTransitionable?

    func showActionsModule(output: ActionsWithTrashButtonModuleOutput) {
        let alertController = ActionsWithTrashButtonAlertViewController(output: output)
        view?.presentScreen(alertController, animated: true, completion: nil)
    }
}
