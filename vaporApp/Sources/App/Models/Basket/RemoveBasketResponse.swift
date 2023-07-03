//Created by chizztectep on 03.07.2023 

import Vapor

struct RemoveBasketResponse: Content {
    let result: Int
    let errorMessage: String?
}
