//Created by chizztectep on 03.07.2023 

import Vapor

/**
 Добавление товара в корзину
 
 - Parameters:
  - id_product: id продукта (Int)
  - quantity: количество (Int)
 */
struct AddBasketRequest: Content {
    var id_product: Int
    var quantity: Int
}
