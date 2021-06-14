import UIKit

class MainView: UITableViewController {

    var presenter: MainViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(selectMovieList))
    }
    
    @objc fileprivate func selectMovieList() {
        let ac = UIAlertController(title: "Select movie list", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Popular", style: .default, handler: listSelector(search: 1)))
        ac.addAction(UIAlertAction(title: "Top rated", style: .default, handler: listSelector(search: 2)))
        ac.addAction(UIAlertAction(title: "Upcoming", style: .default, handler: listSelector(search: 3)))
        ac.addAction(UIAlertAction(title: "Now Playing", style: .default, handler: listSelector(search: 4)))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    // скорее всего стоит переместить в презентер
    fileprivate func listSelector(search: Int) -> (_ action: UIAlertAction) -> () {
        return { [unowned self] action in
            self.presenter.currentPage = 0
            switch search {
            case 1:
                self.presenter.currentList = .popular
            case 2:
                self.presenter.currentList = .topRated
            case 3:
                self.presenter.currentList = .upcoming
            case 4:
                self.presenter.currentList = .nowPlaying
            default:
                return
            }
            presenter.movieList = []
            self.presenter.getMovies()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieCell
        let movie = presenter.movieList[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.popularityLabel.text = String(movie.popularity ?? 0.0)
        cell.ratingLabel.text = String(movie.voteAverage ?? 0.0)
        cell.overviewLabel.text = movie.overview ?? ""
        presenter.getPoster(path: movie.posterPath ?? "d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg") { image in
            if let image = image {
                cell.posterView.image = image
                cell.activity.stopAnimating()
            }
        }
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !presenter.isLoadingList){
            presenter.isLoadingList = true
            presenter.loadMoreItemsForList()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movieList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MovieCell
        let movie = presenter.movieList[indexPath.row]
        guard let poster = cell.posterView.image else { return }
        presenter.tapOnMovie(movie: movie, poster: poster)
    }
}



extension MainView: MainViewProtocol {
    
    func succes(list: movieList) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.navigationItem.title = list.rawValue
        }
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

