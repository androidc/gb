//Created by chizztectep on 25.06.2023 

import Vapor

struct GetReviewsResponse: Content {
    let id_user: Int
    let id_comment: Int
    let text: String
    let errorMessage: String? 
}
