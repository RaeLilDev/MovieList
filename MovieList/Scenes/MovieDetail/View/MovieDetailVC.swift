//
//  MovieDetailVC.swift
//  MovieList
//
//  Created by Ye linn htet on 8/28/23.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var containerCover: UIView!
    @IBOutlet weak var viewWatchList: UIStackView!
    @IBOutlet weak var lblWatchList: UILabel!
    @IBOutlet weak var ivWatchList: UIImageView!
    @IBOutlet weak var viewWatchTrailer: UIStackView!
    @IBOutlet weak var lblShortDesc: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblReleasedDate: UILabel!
    
    var viewModel: MovieDetailViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        setupGestureRecognizers()
        
        bindData()
        
        viewModel.fetchMovieDetail()
    }

    //MARK: - Setup View
    private func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        ivCover.layer.cornerRadius = 8.0
        containerCover.layer.cornerRadius = 8.0
        containerCover.dropShadow(opacity: 0.05, radius: 4, width: 0, height: 4)
        viewWatchList.layer.cornerRadius = viewWatchList.bounds.height / 2
        viewWatchTrailer.layer.cornerRadius = viewWatchTrailer.bounds.height / 2
        viewWatchTrailer.layer.borderColor = UIColor.label.cgColor
        viewWatchTrailer.layer.borderWidth = 1.0
    }
    
    private func setupGestureRecognizers() {
        let tapWatchList = UITapGestureRecognizer(target: self, action: #selector(onTapWatchList))
        viewWatchList.isUserInteractionEnabled = true
        viewWatchList.addGestureRecognizer(tapWatchList)
        
        let tapWatchTrailer = UITapGestureRecognizer(target: self, action: #selector(onTapWatchTrailer))
        viewWatchTrailer.isUserInteractionEnabled = true
        viewWatchTrailer.addGestureRecognizer(tapWatchTrailer)
    }
    
    //MARK: - Bind Data
    private func bindData() {
        viewModel.movieObservable.subscribe(onNext: {[weak self] data in
            guard let self = self else { return }
            if let movie = data {
                self.bindUI(with: movie)
            }
            
        }).disposed(by: disposeBag)
    }
    
    private func bindUI(with movie: MovieRO) {
        let isSaved = movie.isSaved ?? false
        ivCover.image = UIImage(named: movie.photo ?? "")
        lblTitle.text = movie.title
        lblRating.text = "\(movie.rating ?? 0.0)"
        lblWatchList.text = isSaved ? "REMOVE FROM WATCHLIST" : "ADD TO WATCHLIST"
        ivWatchList.image = isSaved ? UIImage(systemName: "minus") : UIImage(systemName: "plus")
        lblShortDesc.text = movie.desc
        lblGenre.text = movie.genre
        lblReleasedDate.text = movie.releaseDate?.toString(format: .type3)
    }
    
    //MARK: - Ontap Callbacks
    @objc private func onTapWatchList() {
        viewModel.manageWatchList()
    }
    
    @objc private func onTapWatchTrailer() {
        let trailerLink = viewModel.getTrailerLink()
        if let url = URL(string: trailerLink) {
            UIApplication.shared.open(url)
        }
    }

}
