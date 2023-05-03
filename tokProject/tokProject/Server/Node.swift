//Created by chizztectep on 02.05.2023 

import Foundation

enum WorkerStatus {
    case running
    case finished
}

class Worker {
    var id: String
    var workerStatus: WorkerStatus
    
    init(id: String, workerStatus: WorkerStatus) {
        self.id = id
        self.workerStatus = workerStatus
    }
}

class Node {
    private var mail: String
    private var password: String
    var workers: [Worker] = []
    var lock = NSLock()
    
    init(mail: String, password: String) {
        self.mail = mail
        self.password = password
    }
    
    
    
    private func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    
    
    private func getTokenAndCallApi(id: String, worker: Worker, on service: Service)  throws -> String {
        
       
        print("blocking db")
        TokenShare.shared.isLocked = true
        //делаем запрос авторизации
        let service_token = service.authenticate(mail: self.mail, password: self.password)
        if service_token == "" {
            // разблокируем БД
            TokenShare.shared.isLocked = false
           
            
            // завершаем worker
            workers.filter {$0.id == id }.first?.workerStatus = .finished
          //  worker.workerStatus = .finished
            //удаляем worker из массива workers
           // workers.removeAll (where: {$0.id == id})
            // throw exception
            throw tokenError.wrongMailPass
        }
        TokenShare.shared.token = service_token
        // разблокируем БД
        print("unblocking db")
        TokenShare.shared.isLocked = false
        let response =  service.callApi(token: service_token, id: id)
        // завершаем worker
        workers.filter {$0.id == id }.first?.workerStatus = .finished
       // worker.workerStatus = .finished
        //удаляем worker из массива workers
      //  workers.removeAll (where: {$0.id == id})
        return response
    }


    func performRequest(id: String, on service: Service)  throws -> String?  {
        
        // добавляем worker .running
        let worker = Worker(id: id, workerStatus: .running)
        lock.with { workers.append(worker)}
        // блокируем БД
        
        //var token: String?
        var count = 0
        
        // getToken from tokenShare
        print("getToken from tokenShare")
  
        while (TokenShare.shared.isLocked && count < 15) {
            count += 1
            delay(1) {print("db is locked now")}
        }
        
//        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//            if !TokenShare.shared.isLocked || count >= 15 {
//                //token = TokenShare.shared.token
//                timer.invalidate()
//            }
//            count += 1
//        }
//
       
        
        guard count < 15 else {
            // завершаем worker
            workers.filter {$0.id == id }.first?.workerStatus = .finished
            //worker.workerStatus = .finished
            //удаляем worker из массива workers
            //workers.removeAll (where: {$0.id == id})
            
            throw tokenError.longBlocking
        }
        

        // получили токен из бд (или nil если никто еще токен туда не записал)
        // проверяем есть токен или нет
        guard let token = TokenShare.shared.token else {
            // если нет токена, то
            print("no token in TokenShare, request it")
            print("request new token and call api with id: \(id)")
            let data = try  getTokenAndCallApi(id: id, worker: worker, on: service)
          
            return data
        }
            
        // если есть токен, то
        // запрос api с этим токеном
        print("call api with id: \(id)")
        let data =  service.callApi(token: token, id: id)
        if data != "token error" {
            
            workers.filter {$0.id == id }.first?.workerStatus = .finished
            // завершаем worker // здесь вылетает ошибка!
           // worker.workerStatus = .finished
            //удаляем worker из массива workers
          // workers.removeAll (where: {$0.id == id})
            
            
            return data
        } else {
            // проверяем что бд не блокирована
            count = 0
            var token2: String?
            print("check if db is blocked")
            while (TokenShare.shared.isLocked && count < 15) {
                token2 = TokenShare.shared.token
                count += 1
                delay(1) {print("db is locked now")}
            }
//            let timer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//                if !TokenShare.shared.isLocked || count >= 15 {
//                    token2 = TokenShare.shared.token
//                    timer.invalidate()
//                }
//                count += 1
//            }
            
            guard count < 15 else {
                // завершаем worker
                workers.filter {$0.id == id }.first?.workerStatus = .finished
                //worker.workerStatus = .finished
                //удаляем worker из массива workers
                //workers.removeAll (where: {$0.id == id})
                throw tokenError.longBlocking
            }
            
            // если count >= 1 значит бд была блокирована
            if count >= 1 {
                // делаем запрос с новым токеном
                // если токен не появился, то это какой-то косяк
                guard let tokenNew = token2 else {
                    // завершаем worker
                    workers.filter {$0.id == id }.first?.workerStatus = .finished
                   // worker.workerStatus = .finished
                    //удаляем worker из массива workers
                    //workers.removeAll (where: {$0.id == id})
                    throw tokenError.noToken
                }
                print("call api with id: \(id)")
                // завершаем worker
                workers.filter {$0.id == id }.first?.workerStatus = .finished
               // worker.workerStatus = .finished
                //удаляем worker из массива workers
               // workers.removeAll (where: {$0.id == id})
                return  service.callApi(token: tokenNew, id: id)
             
            } else {
                // бд не была блокирована
                print("request new token and call api with id: \(id)")
                let data = try  getTokenAndCallApi(id: id, worker: worker, on: service)
               
                return data
            }
      
        }
        
        
        
        
        
    }
    
    
}

extension NSLock {

    @discardableResult
    func with<T>(_ block: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try block()
    }
}
