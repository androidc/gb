//Created by chizztectep on 24.06.2023 

import Vapor

struct LoginResponse: Content {
    var result: Int
    var user: User?
    var errorMessage: String?
}


struct User: Content {
    let id_user: Int
    let user_login: String
    let user_name: String
    let user_lastname: String
}
