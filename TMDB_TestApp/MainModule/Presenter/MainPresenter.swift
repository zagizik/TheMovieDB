import UIKit

protocol MainViewProtocol: AnyObject {
    func succes(list: movieList)
//    func setPoster(posterData: UIImage?)
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init (view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getMovies()
    func tapOnMovie(movie: Movie?, poster: UIImage)
    func getPoster(path: String, completion: @escaping (UIImage?) -> Void)
    var movieList: [Movie] { get set }
    var currentPage: Int { get set }
    var isLoadingList: Bool { get set }
    func loadMoreItemsForList()
    var currentList: movieList { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol?
    var router: RouterProtocol?
    var movieList: [Movie]
    var currentList: movieList
    
//    pagination
    var currentPage: Int = 0
    var isLoadingList: Bool = false
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        movieList = []
        currentList = .popular
        getMovies()
    }
    
    func loadMoreItemsForList() {
        if currentPage == 0 {
            currentPage = 2
        } else { currentPage += 1 }
        
        getMovies()
        
        
    }
    
    func getMovies() {
        networkService?.getMovieList(list: currentList, page: currentPage ,complition: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.view?.failure(error: error)
            case .success(let movieList):
                self.movieList.append(contentsOf: movieList!)
                self.view?.succes(list: self.currentList)
                self.isLoadingList = false
            }
        })
    }
    
    func getPoster(path: String, completion: @escaping (UIImage?) -> Void) {
        networkService?.downloadImage(urlString: path) { result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let image):
                completion(image)
            }
        }
    }
    
    func tapOnMovie(movie: Movie?, poster: UIImage) {
        router?.showDetail(movie: movie, poster: poster)
    }
}
