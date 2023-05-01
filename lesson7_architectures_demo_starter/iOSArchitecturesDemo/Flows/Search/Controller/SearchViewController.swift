//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    
    private let searchService = ITunesSearchService()
    internal var searchResults = [SearchAppCellModel]() {
        didSet {
            searchView.tableView.isHidden = false
            searchView.tableView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }
    
    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }
    
    //private let presenter: SearchViewOutput
    private let viewModel: SearchViewModel
    
//    init(presenter: SearchViewOutput) {
//        self.presenter = presenter
//        super.init(nibName: nil, bundle: nil)
//    }
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
        
        // bind view и viewModel
        bindViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
    
    private func bindViewModel() {
        viewModel.isLoading.addObserver(self) { [weak self] (isLoading, _) in
            self?.throbber(show: isLoading)
        }
        
        // если пришла ошибка то алерт
        self.viewModel.error.addObserver(self) { [weak self] (error, _) in
            if let error = error {
                self?.showError(error: error)
            }
        }
       
        self.viewModel.showEmptyResults.addObserver(self) { [weak self] (showEmptyResults, _) in
            self?.searchView.emptyResultView.isHidden = !showEmptyResults
            self?.searchView.tableView.isHidden = showEmptyResults
        }
        
        self.viewModel.cellModel.addObserver(self) { [weak self] (searchResults, _)  in
            self?.searchResults = searchResults
        }
        
    }
    
  
    

    

}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? AppCell else {
            return dequeuedCell
        }
        let app = self.searchResults[indexPath.row]
//        let cellModel = AppCellModelFactory.cellModel(from: app)
//        cell.configure(with: cellModel)
        
        cell.titleLabel.text = app.appName
        cell.subtitleLabel.text = app.company
        cell.ratingLabel.text = app.averageRating >>- {"\($0)"}
        switch app.downloadState {
        case .notStarted:
            cell.titleLabel.text = nil
        case .inProgress(let progress):
            let progressToShow = round(progress * 100.0) / 100.0
            cell.titleLabel.text = "\(progressToShow)"
        case .downloaded:
            cell.titleLabel.text = "Загружено"
        }
        return cell
    }
    
    
       func showError(error: Error) {
            let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(actionOk)
            self.present(alert, animated: true, completion: nil)
        }
    
     func showNoResults() {
            self.searchView.emptyResultView.isHidden = false
        }
    
     func hideNoResults() {
            self.searchView.emptyResultView.isHidden = true
        }
    
        internal func throbber(show: Bool) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = show
        }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let app = searchResults[indexPath.row]
        
        viewModel.ditTapDownloadApp(app)
       // presenter.viewDidSelect(app)
       // let appDetaillViewController = AppDetailViewController(app:app)
//        appDetaillViewController.app = app
//        navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        self.viewModel.search(for: query)
       // presenter.viewDidSearch(with: query)
        //self.requestApps(with: query)
    }
}
//
//extension SearchViewController: SearchViewInput{
//   func showError(error: Error) {
//        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
//        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        alert.addAction(actionOk)
//        self.present(alert, animated: true, completion: nil)
//    }
//
// func showNoResults() {
//        self.searchView.emptyResultView.isHidden = false
//    }
//
// func hideNoResults() {
//        self.searchView.emptyResultView.isHidden = true
//    }
//
//    internal func throbber(show: Bool) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = show
//    }
//}
