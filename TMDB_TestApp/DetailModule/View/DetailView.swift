//
//  DetailView.swift
//  TMDB_TestApp
//
//  Created by Александр Банников on 03.06.2021.
//

import UIKit

class DetailView: UIViewController {
    
    var presenter: DetailPresenterProtocol!
    
    let scrollView: UIScrollView = {
        let sc = UIScrollView()
        return sc
    }()
    
    let moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    let movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        scrollView.addSubview(moviePoster)
        moviePoster.anchor(top: scrollView.safeAreaLayoutGuide.topAnchor, leading: scrollView.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: scrollView.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10), size: .init(width: view.frame.width - 20, height: view.frame.height / 2))
        scrollView.addSubview(movieTitleLabel)
        movieTitleLabel.anchor(top: moviePoster.safeAreaLayoutGuide.bottomAnchor, leading: scrollView.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: scrollView.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10), size: .init(width: view.frame.width - 20, height: 30))
        scrollView.addSubview(movieOverviewLabel)
        movieOverviewLabel.anchor(top: movieTitleLabel.bottomAnchor, leading: scrollView.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: scrollView.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        presenter.setMovie()
    }

}

extension DetailView: DetailViewProtocol {
    func setPoster(poster: UIImage?) {
        guard let poster = poster else { return }
        DispatchQueue.main.async {
            self.moviePoster.image = poster
        }
    }
    
    func setDetailView(movie: Movie?) {
        navigationItem.title = movie?.title
        movieTitleLabel.text = movie?.title
        movieOverviewLabel.text = movie?.overview
    }
}
