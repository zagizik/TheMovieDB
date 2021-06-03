import Foundation

protocol DetailViewProtocol: AnyObject {
    func setDetailView(movie: Movie?)
}

protocol DetailPresenterProtocol: AnyObject {
    init (view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, movie: Movie?)
    func setMovie()
    func tapToRoot()
}

class DetailPresenter: DetailPresenterProtocol {

    
    func setMovie() {
        self.view?.setDetailView(movie: movie)
    }
    
    func tapToRoot() {
        router?.popToRoot()
    }
    
    
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol
    var router: RouterProtocol?
    let movie: Movie?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, movie: Movie?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.movie = movie
    }
    
    func setDetailView(movie: Movie?) {
        
    }
}
