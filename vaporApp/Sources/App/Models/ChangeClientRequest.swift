//Created by chizztectep on 24.06.2023 

import Vapor


struct ChangeClientRequest : Content {
    var id_user: Int
    var username: String
    var password: String
    var email: String
    var gender: String
    var credit_card: String
    var bio: String
}
