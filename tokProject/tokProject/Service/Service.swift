//Created by chizztectep on 02.05.2023 

import Foundation



class Service {
    var email:String = "admin"
    var pass:String = "admin"
    var token:String = "asdfasdf"
    
//    init(){
//
//    }
    
    func authenticate(mail:String,password:String) -> String {
        if mail == email, pass == password {
            return token
        } else {return ""}
    }
    
    func callApi(token: String) -> String {
        if token == self.token {
            return "data"
        } else {return "token error"}
    }
}
