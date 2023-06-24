//Created by chizztectep on 24.06.2023 

import Vapor


struct ChangeClientResponse: Content {
    var result: Int
    var errorMessage: String?
}
