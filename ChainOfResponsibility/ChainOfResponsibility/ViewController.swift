//Created by chizztectep on 15.04.2023 

import UIKit

enum LoginError: Error {
    case loginDoesNotExist
    case wrongPassword
    case smsCodeInvalid
}

enum NetworkError: Error {
    case noConnection
    case serverNotResponding
}

enum GeneralError: Error {
    case sessionInvalid
    case versionIsNotSupported
    case generalx
}

protocol ErrorHandler {
    var next: ErrorHandler? {get set}
    func handleError(_ error: Error)
}

class LoginHandler: ErrorHandler{
    var next: ErrorHandler?
    
    func handleError(_ error: Error) {
        print("Login handler try to handle error")
        
        guard let loginError = error as? LoginError else {
            self.next?.handleError(error)
            return
        }
        
        print(loginError)
    }
}


class NetworkHandler: ErrorHandler{
    var next: ErrorHandler?
    
    func handleError(_ error: Error) {
        print("Network handler try to handle error")
        
        guard let networkError = error as? NetworkError else {
            self.next?.handleError(error)
            return
        }
        
        print(networkError)
    }
}

class GeneralHandler: ErrorHandler{
    var next: ErrorHandler?
    
    func handleError(_ error: Error) {
        print("General handler try to handle error")
        
        guard let generalError = error as? GeneralError else {
            self.next?.handleError(error)
            return
        }
        
        print(generalError)
    }
}




class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let loginErrorHandler = LoginHandler()
        let networkErrorHandler = NetworkHandler()
        let generalErrorHandler = GeneralHandler()
        
        let errorHandler: ErrorHandler = loginErrorHandler
        loginErrorHandler.next = networkErrorHandler
        networkErrorHandler.next = generalErrorHandler
        generalErrorHandler.next = nil
        
        requestData { error in
            if let error = error {
                errorHandler.handleError(error)
            }
        }
    }
    
    func requestData(completion: @escaping (Error?)->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            completion(LoginError.loginDoesNotExist)
        }
    }


}

