//Created by chizztectep on 24.06.2023 

import Vapor

class AuthController {
    func register(_ req: Request) throws -> EventLoopFuture<RegisterResponse> {
        guard let body = try? req.content.decode(RegisterRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        
        let response = RegisterResponse(
            result: 1,
            userMessage: "Регистрация прошла успешно!",
            errorMessage: nil
        )
        return req.eventLoop.future(response)
    }
    
    func login(_ req: Request) throws -> EventLoopFuture<LoginResponse> {
        guard let body = try? req.content.decode(LoginRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        // check user and password
        
        if body.password == "111" && body.username == "111" {
            let response = LoginResponse(
                result: 1,
                user: User(id_user: 123, user_login: "geekbrains", user_name: "John", user_lastname: "Doe"),
                errorMessage: nil
            )
            return req.eventLoop.future(response)
        } else {
            let response = LoginResponse(
                result: 0,
                user: nil,
                errorMessage: "user not found"
            )
            
            return req.eventLoop.future(response)
        }
        
        
    }
    
    func logout(_ req: Request) throws -> EventLoopFuture<LogoutResponse> {
        guard let body = try? req.content.decode(LogoutRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        let response = LogoutResponse(
            result: 1,
            errorMessage: nil
        )
        return req.eventLoop.future(response)
    }
}
