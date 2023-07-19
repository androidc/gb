//Created by chizztectep on 18.07.2023 

import Vapor

struct GetBasketResponse: Content {
    var id_product: Int
    var quantity: Int
    var price: Int
    var name: String
}
