//Created by chizztectep on 28.06.2023 

import Vapor

struct RemoveReviewResponse: Content {
    let result: Int
    let errorMessage: String?
}
