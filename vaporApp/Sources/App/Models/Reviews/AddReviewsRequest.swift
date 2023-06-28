//Created by chizztectep on 27.06.2023 

import Vapor

struct AddReviewsRequest: Content {
    var id_user: Int
    var text: String
}
