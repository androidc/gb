//Created by chizztectep on 03.07.2023

import Vapor

struct PayBasketResponse: Content {
    let result: Int
    let errorMessage: String?
}
