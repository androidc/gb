//Created by chizztectep on 24.06.2023 

import Vapor


struct ProductDataResponse: Content {
    var result: Int
    var product_name: String
    var product_price: Int
    var product_description: String
    var errorMessage: String?
}
