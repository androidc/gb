//Created by chizztectep on 24.06.2023 

import Vapor

struct LoginRequest: Content {
    var username: String
    var password: String
}
