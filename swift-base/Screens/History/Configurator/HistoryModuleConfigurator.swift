
import UIKit

final class HistoryModuleConfigurator {
    func configure(output: HistoryModuleOutput? = nil) -> HistoryViewController {

        let headerView = HistoryHeaderView()
        let archiver = Archiver()

        let router = HistoryRouter()
        let tableAdapter = HistoryTableAdapter()
        let presenter = HistoryPresenter(router: router,
                                          archiver: archiver)

        let view = HistoryViewController(output: presenter,
                                          tableAdapter: tableAdapter,
                                          headerView: headerView)
        
        presenter.view = view
        presenter.output = output
        headerView.output = presenter
        router.view = view
        tableAdapter.output = presenter
        
        return view
    }
}
