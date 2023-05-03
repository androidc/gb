//Created by chizztectep on 02.05.2023 

import Foundation

class Node {
    private var mail: String
    private var password: String
    private var service: Service = Service()
    
    
    init(mail: String, password: String) {
        self.mail = mail
        self.password = password
    }
    
    
    
    private func getTokenAndCallApi() throws -> String {
        // блокируем БД
        print("blocking db")
        TokenShare.shared.isLocked = true
        //делаем запрос авторизации
        let service_token = service.authenticate(mail: self.mail, password: self.password)
        if service_token == "" {
            // разблокируем БД
            TokenShare.shared.isLocked = false
            // throw exception
            throw tokenError.wrongMailPass
        }
        TokenShare.shared.token = service_token
        // разблокируем БД
        print("unblocking db")
        TokenShare.shared.isLocked = false
        return service.callApi(token: service_token)
    }
    
    func performRequest() throws -> String?  {
        var token: String?
        var count = 0
        
        // getToken from tokenShare
        print("getToken from tokenShare")
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if !TokenShare.shared.isLocked || count >= 15 {
                token = TokenShare.shared.token
                timer.invalidate()
            }
            count += 1
        }
        
        guard count < 15 else {
            throw tokenError.longBlocking
        }
        

        // получили токен из бд (или nil если никто еще токен туда не записал)
        // проверяем есть токен или нет
        guard let token = TokenShare.shared.token else {
            // если нет токена, то
            print("no token in TokenShare, request it")
            let data = try getTokenAndCallApi()
            return data
        }
            
        // если есть токен, то
        // запрос api с этим токеном
        let data = service.callApi(token: token)
        if data != "token error" {
            return data
        } else {
            // проверяем что бд не блокирована
            count = 0
            var token2: String?
            print("check if db is blocked")
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if !TokenShare.shared.isLocked || count >= 15 {
                    token2 = TokenShare.shared.token
                    timer.invalidate()
                }
                count += 1
            }
            
            guard count < 15 else {
                throw tokenError.longBlocking
            }
            
            // если count >= 1 значит бд была блокирована
            if count >= 1 {
                // делаем запрос с новым токеном
                // если токен не появился, то это какой-то косяк
                guard let tokenNew = token2 else {
                    throw tokenError.noToken
                }
                return service.callApi(token: tokenNew)
             
            } else {
                // бд не была блокирована
                let data = try getTokenAndCallApi()
                return data
            }
      
        }
        
        
        
        
        
    }
    
    
}
