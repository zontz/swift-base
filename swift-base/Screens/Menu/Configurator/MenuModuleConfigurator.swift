
import UIKit

final class MenuModuleConfigurator {
    func configure(output: MenuModuleOutput? = nil) -> MenuViewController {

        let categoryView = CurrentCategoryView()
        let lastGameView = LastGameView()
        let jsonLoader = JSONLoader()
        let archiver = Archiver()

        let router = MenuRouter()
        let presenter = MenuPresenter(router: router,
                                       jsonLoader: jsonLoader,
                                       archiver: archiver)

        let view = MenuViewController(output: presenter,
                                       categoryView: categoryView,
                                       lastGame: lastGameView)
        
        presenter.view = view
        presenter.output = output
        categoryView.output = presenter
        router.view = view

        return view
    }
}
