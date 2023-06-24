//Created by chizztectep on 24.06.2023 

import Vapor

struct RegisterResponse: Content {
    var result: Int
    var userMessage: String?
    var errorMessage: String?
}
