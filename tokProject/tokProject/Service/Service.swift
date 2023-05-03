//Created by chizztectep on 02.05.2023 

import Foundation



class Service {
    var email:String = "admin"
    var pass:String = "admin"
    var token:String = "initial"
    var tokenExpired: Bool = false
    
    init(){
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            self.tokenExpired = true
        }

    }
    
    func authenticate(mail:String,password:String) -> String {
        if mail == email, pass == password {
            token = UUID().uuidString
            tokenExpired = false
            return token
        } else {return ""}
    }
    
    func doAsyncWork(token: String, id: String) async {
        print("Doing async work")
    }

    
    func callApi(token: String, id: String)  -> String {
        if (token == self.token && !tokenExpired)  {
           let delayValue:Double = Double((1...9).randomElement()!)
            let duration = UInt32(delayValue)
            sleep(duration)
//            try await Task.sleep(duration)
            print("call api success. id: \(id)")
            return "data returned with delay: \(delayValue)"
        } else {return "token error"}
    }
}
