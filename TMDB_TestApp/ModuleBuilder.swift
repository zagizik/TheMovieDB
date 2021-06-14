import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(movie: Movie?, poster: UIImage, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = MainView()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(movie: Movie?, poster: UIImage, router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = DetailView()
        let poster = poster
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, movie: movie, poster: poster)
        view.presenter = presenter
        return view
    }
}
