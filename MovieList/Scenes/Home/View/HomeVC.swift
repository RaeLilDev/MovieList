//
//  HomeVC.swift
//  MovieList
//
//  Created by Ye linn htet on 8/28/23.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: UIViewController {

    @IBOutlet weak var tableViewMovies: UITableView!
    
    var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupTableView()
        viewModel.saveMovieList()
        let sortByName = Preference.getBool(forKey: .sortByName)
        viewModel.fetchMovieList(by: sortByName ? "title": "releaseDate")
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    //MARK: - Setup View
    private func setupNavbar() {
        self.navigationItem.title = "Movies"
        let btnSort = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector(onTapSort))
        self.navigationItem.rightBarButtonItem = btnSort
    }
    
    private func setupTableView() {
        tableViewMovies.dataSource = self
        tableViewMovies.delegate = self
        tableViewMovies.registerCell(from: MovieItemCell.self)
    }
    
    //MARK: - Bind Data
    private func bindData() {
        viewModel.movieListObservable.subscribe(onNext: {[weak self] data in
            guard let self = self else { return }
            self.tableViewMovies.reloadData()
        }).disposed(by: disposeBag)
    }
    
    //MARK: - OnTap Callbacks
    @objc private func onTapSort() {
        showSortOptionsSheet()
    }
    
    func showSortOptionsSheet() {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let titleAction = UIAlertAction(title: "Title", style: .default, handler: { _ in
            self.viewModel.fetchMovieList(by: "title")
            Preference.setValue(true, forKey: .sortByName)
        })
        let releasedDateAction: UIAlertAction = UIAlertAction(title: "Released Date", style: .default, handler: { _ in
            self.viewModel.fetchMovieList(by: "releaseDate")
            Preference.setValue(false, forKey: .sortByName)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        titleAction.setValue(UIColor.lightGray, forKey: "titleTextColor")
        releasedDateAction.setValue(UIColor.lightGray, forKey: "titleTextColor")
        cancelAction.setValue(UIColor.label, forKey: "titleTextColor")
        
        sheet.addAction(titleAction)
        sheet.addAction(releasedDateAction)
        sheet.addAction(cancelAction)
        
        if let popoverPresentationController = sheet.popoverPresentationController {
            if let view = self.parent?.view {
                popoverPresentationController.sourceRect = CGRectMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds), 1, 1);
                popoverPresentationController.sourceView = view
                popoverPresentationController.permittedArrowDirections = []
            }
        }
        self.parent?.present(sheet, animated: true, completion: nil)
    }

}

//MARK: - TableView Datasource

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMovieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(from: MovieItemCell.self, at: indexPath)
        cell.data = viewModel.getMovie(by: indexPath.row)
        return cell
    }
}

//MARK: - TableView Delegate
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = viewModel.getMovie(by: indexPath.row).id
        presentDetail(with: movieId)
    }
    
    private func presentDetail(with id: Int) {
        let vc = MovieDetailVC()
        vc.viewModel = MovieDetailViewModel(movieModel: MovieModelImpl.shared, movieId: id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
