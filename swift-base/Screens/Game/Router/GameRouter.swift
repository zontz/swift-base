import UIKit

protocol GameRouterInput {
    func showMenuModule()
    func showPopUpView(output: PopUpViewOutput?,
                       mainText: String,
                       secondText: String,
                       closeButtonText: String)
}

final class GameRouter {
    weak var view: ModuleTransitionable?
}

// MARK: - GameRouterInput

extension GameRouter: GameRouterInput {
    func showPopUpView(output: PopUpViewOutput?,
                       mainText: String,
                       secondText: String,
                       closeButtonText: String) {
        
        let popUpView = PopUpViewController(output: output,
                                            mainText: mainText,
                                            secondText: secondText,
                                            closeButtonText: closeButtonText)
        view?.presentScreen(popUpView, animated: true, completion: nil)
    }
    
    func showMenuModule() {
        view?.dismissView(animated: true, completion: nil)
    }
}
