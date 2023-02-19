
import UIKit

final class GameModuleConfigurator {
    func configure(output: GameModuleOutput? = nil, with category: Category = Category()) -> GameViewController {

        let progressView = GameProgressView()
        let archiver = Archiver()
        let questionService = QuestionService()
        
        let router = GameRouter()
        let presenter = GamePresenter(router: router,
                                       with: category,
                                       arciver: archiver,
                                       questionService: questionService)

        let view = GameViewController.init(output: presenter,
                                            progressView: progressView)

        progressView.output = presenter
        presenter.view = view
        presenter.output = output
        router.view = view
        
        return view
    }
}
