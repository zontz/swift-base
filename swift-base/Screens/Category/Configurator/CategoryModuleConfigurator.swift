
import UIKit

final class CategoryModuleConfigurator {
    func configure(output: CategoryModuleOutput? = nil) -> CategoryViewController {

        let headerView = HeaderCategoryScreenView()
        let archiver = Archiver()

        let router = CategoryRouter()
        let tableAdapter = CategoryTableAdapter()
        let presenter = CategoryPresenter.init(router: router, archiver: archiver)
        let view = CategoryViewController.init(output: presenter,
                                               tableAdapter: tableAdapter,
                                               headerView: headerView)
        
        presenter.view = view
        presenter.output = output
        router.view = view
        tableAdapter.output = presenter
        
        return view
    }
}
