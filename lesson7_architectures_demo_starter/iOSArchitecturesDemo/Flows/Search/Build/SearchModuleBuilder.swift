//Created by chizztectep on 23.04.2023 

import Foundation
import UIKit

class SearchModuleBuilder {
    
//    static func build() -> (UIViewController & SearchViewInput) {
//        let searchService = ITunesSearchService()
//        let presenter = SearchPresenter()
//        let viewController = SearchViewController(presenter: presenter)
//        presenter.viewInput = viewController
//        return viewController
//    }
    
    static func build() -> (UIViewController) {
        let searchService = ITunesSearchService()
        let downloadService = FakeDownloadAppService()
        let viewModel = SearchViewModel(searchService: searchService, downloadAppService: downloadService)
        
        let viewController = SearchViewController(viewModel: viewModel)
     
        return viewController
    }
}
