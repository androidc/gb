//Created by chizztectep on 24.06.2023 

import Vapor

struct CatalogDataResponse: Content {
    var id_product: Int
    var product_name: String
    var price: Int
    var errorMessage: String?
}
