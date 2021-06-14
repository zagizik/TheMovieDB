import UIKit

protocol DetailViewProtocol: AnyObject {
    func setDetailView(movie: Movie?, poster: UIImage)
    func setPoster(poster: UIImage?)
}

protocol DetailPresenterProtocol: AnyObject {
    init (view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, movie: Movie?, poster: UIImage)
    func setMovie()
    func tapToRoot()
}

class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol
    var router: RouterProtocol?
    let movie: Movie?
    let poster: UIImage
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, movie: Movie?, poster: UIImage) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.movie = movie
        self.poster = poster
    }
    
    func setMovie() {
        self.view?.setDetailView(movie: movie, poster: poster)
    }
    
    func tapToRoot() {
        router?.popToRoot()
    }
}
