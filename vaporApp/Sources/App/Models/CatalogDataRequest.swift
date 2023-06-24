//Created by chizztectep on 24.06.2023 

import Vapor


struct CatalogDataRequest : Content {
    var page_number: Int
    var id_category: Int
}
