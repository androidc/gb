//Created by chizztectep on 22.04.2023 

import Foundation
import UIKit

//protocol SearchViewInput: AnyObject {
//
//    var searchResults: [ITunesApp] {get set}
//
//    func showError(error: Error)
//    func showNoResults()
//    func hideNoResults()
//    func throbber(show: Bool)
//
//}
//
//protocol SearchViewOutput: AnyObject {
//    func viewDidSearch(with query: String)
//    func viewDidSelect(_ app: ITunesApp)
//}

struct SearchAppCellModel {
    let appName: String
    let company: String?
    let averageRating: Float?
    let downloadState: DownloadingApp.DownloadState
}

class SearchViewModel {
    
    
    // Observable properties
    
    let cellModel = Observable<[SearchAppCellModel]>([])
    
    let isLoading = Observable<Bool>(false)
    let showEmptyResults = Observable<Bool>(false)
    let error = Observable<Error?>(nil)
    
    
    weak var viewController: UIViewController?
    private var apps:[ITunesApp] = []
    private let downloadAppService:DownloadAppSI
    private var searchService = ITunesSearchService()
    
  //  weak var viewInput : (UIViewController & SearchViewInput)?
    
    init(searchService: ITunesSearchService, downloadAppService: DownloadAppSI) {
        self.searchService = searchService
        self.downloadAppService = downloadAppService
        
        downloadAppService.onProgressUpdate = { [weak self] in
            guard let self = self else {return}
            
            self.cellModel.value = self.viewModels()
            
        }
    }
    
    // MARK: - Private properties
    
    func search(for query: String) {
        self.isLoading.value = true
        
        self.searchService.getApps(forQuery: query) {[weak self] result in
            guard let self = self else {return}
            result.withValue { apps in
                self.apps = apps
                self.cellModel.value = self.viewModels()
                self.isLoading.value = false
                self.showEmptyResults.value = apps.isEmpty
                self.error.value = nil
            } .withError {
                self.apps = []
                self.cellModel.value = []
                self.isLoading.value = false
                self.showEmptyResults.value = true
                self.error.value = $0
            }
        }
    }
    
//    private func requestApps(with query: String) {
//      //  self.viewInput?.throbber(show: true)
//        //self.viewInput?.searchResults = []
//       // self.viewInput?.searchView.tableView.reloadData()
//
//        self.searchService.getApps(forQuery: query) { [weak self] result in
//            guard let self = self else { return }
//            self.viewInput?.throbber(show: false)
//            result
//                .withValue { apps in
//                    guard !apps.isEmpty else {
//                        self.viewInput?.searchResults = []
//                        self.viewInput?.showNoResults()
//                        return
//                    }
//                    self.viewInput?.hideNoResults()
//                    self.viewInput?.searchResults = apps
//
//                    //self.searchView.tableView.isHidden = false
//                   // self.searchView.tableView.reloadData()
//
//                   // self.searchView.searchBar.resignFirstResponder()
//                }
//                .withError {
//                    self.viewInput?.showError(error: $0)
//                }
//        }
//    }
    
    func ditTapDownloadApp(_ appViewModel: SearchAppCellModel) {
        guard let app = self.app(with: appViewModel) else {return}
        self.downloadAppService.startDownloadApp(app)
    }
    
    private func viewModels() -> [SearchAppCellModel] {
        return self.apps.compactMap { app -> SearchAppCellModel in
            let downloadingApp = self.downloadAppService.downloadingApps.first { downloadignApp -> Bool in
                
                return downloadignApp.app.appName == app.appName
                
            }
            
            return SearchAppCellModel(appName: app.appName, company: app.company, averageRating: app.averageRating, downloadState: downloadingApp?.downloadState ?? .notStarted)
            
        }
    }
    
    private func app(with viewModel: SearchAppCellModel) -> ITunesApp? {
        return self.apps.first {viewModel.appName == $0.appName}
    }
    
//    private func openDetailApp(with app: ITunesApp){
//        let appDetaillViewController = AppDetailViewController(app:app)
//        self.viewInput?.navigationController?.pushViewController(appDetaillViewController, animated: true)
//    }
    
    
}

//extension SearchPresenter: SearchViewOutput {
//    func viewDidSearch(with query: String) {
//        viewInput?.throbber(show: true)
//        requestApps(with: query)
//    }
//
//    func viewDidSelect(_ app: ITunesApp) {
//        openDetailApp(with: app)
//    }
//
//
//}
