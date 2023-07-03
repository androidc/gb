//Created by chizztectep on 03.07.2023 

import Vapor


struct AddBasketRequest: Content {
    var id_product: Int
    var quantity: Int
}
