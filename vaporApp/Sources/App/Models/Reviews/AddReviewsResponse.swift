//Created by chizztectep on 27.06.2023 

import Vapor

struct AddReviewsResponse: Content {
    var result: Int
    var userMessage: String
    var errorMessage: String?
}
