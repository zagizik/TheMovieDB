//
//  DetailView.swift
//  TMDB_TestApp
//
//  Created by Александр Банников on 03.06.2021.
//

import UIKit

class DetailView: UIViewController {
    
    var presenter: DetailPresenterProtocol!
    
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
        view.addSubview(movieTitleLabel)
        movieTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10), size: .init(width: view.frame.width - 20, height: 30))
        view.addSubview(movieOverviewLabel)
        movieOverviewLabel.anchor(top: movieTitleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        presenter.setMovie()
    }

}

extension DetailView: DetailViewProtocol {
    func setDetailView(movie: Movie?) {
        movieTitleLabel.text = movie?.title
        movieOverviewLabel.text = movie?.overview
    }
}
