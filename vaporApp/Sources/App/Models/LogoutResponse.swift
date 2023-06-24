//Created by chizztectep on 24.06.2023 

import Vapor

struct LogoutResponse: Content {
    var result: Int
    var errorMessage: String?
}
