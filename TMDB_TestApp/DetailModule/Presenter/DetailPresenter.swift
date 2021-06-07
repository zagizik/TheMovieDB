import UIKit

protocol DetailViewProtocol: AnyObject {
    func setDetailView(movie: Movie?)
    func setPoster(poster: UIImage?)
}

protocol DetailPresenterProtocol: AnyObject {
    init (view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, movie: Movie?)
    func setMovie()
    func tapToRoot()
    func getPoster()
}

class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol
    var router: RouterProtocol?
    let movie: Movie?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, movie: Movie?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.movie = movie
        getPoster()
    }
    
    func setMovie() {
        self.view?.setDetailView(movie: movie)
    }
    
    func getPoster() {
        networkService.fetchImage(from: movie?.posterPath) { [weak self] result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                let poster = UIImage(data: data)
                self?.view?.setPoster(poster: poster)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func tapToRoot() {
        router?.popToRoot()
    }
}
