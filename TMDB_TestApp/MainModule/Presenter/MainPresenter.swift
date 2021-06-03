import UIKit

protocol MainViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init (view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getMovies()
    func tapOnMovie(movie: Movie?)
    var movieList: [Movie]? { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol?
    var router: RouterProtocol?
    var movieList: [Movie]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getMovies()
    }
    
    func getMovies() {
        networkService?.getTopRated(complition: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.view?.failure(error: error)
            case .success(let movieList):
                self.movieList = movieList
                self.view?.succes()
            }
        })
    }
    
    func tapOnMovie(movie: Movie?) {
        print(movie)
    }
}
