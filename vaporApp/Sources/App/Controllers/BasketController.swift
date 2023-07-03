//Created by chizztectep on 03.07.2023 

import Vapor

class BasketController {
    
    func addBasket(_ req: Request) throws -> EventLoopFuture<AddBasketResponse> {
        guard let body = try? req.content.decode(AddBasketRequest.self) else {
            throw Abort(.badRequest)
        }
        
        let response = AddBasketResponse(result: 1, errorMessage: nil)
        return req.eventLoop.future(response)
    }
    
    func removeBasket(_ req: Request) throws -> EventLoopFuture<RemoveBasketResponse> {
        guard let body = try? req.content.decode(RemoveBasketRequest.self) else {
            throw Abort(.badRequest)
        }
        
        let response = RemoveBasketResponse(result: 1, errorMessage: nil)
        return req.eventLoop.future(response)
    }
    
    func payBasket(_ req: Request) throws -> EventLoopFuture<PayBasketResponse> {
        guard let body = try? req.content.decode(PayBasketRequest.self) else {
            throw Abort(.badRequest)
        }
        
        let response = PayBasketResponse(result: 1, errorMessage: nil)
        return req.eventLoop.future(response)
    }
    
    
}
