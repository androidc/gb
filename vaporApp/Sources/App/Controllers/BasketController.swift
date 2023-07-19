//Created by chizztectep on 03.07.2023 

import Vapor

class BasketController {
    
    func getBasket(_ req: Request) throws -> EventLoopFuture<[GetBasketResponse]> {
        guard let body = try? req.content.decode(GetBasketRequest.self) else {
            throw Abort(.badRequest)
        }
        
        let response = UserData.shared.getBasket()
        return req.eventLoop.future(response)
    }
    
    func addBasket(_ req: Request) throws -> EventLoopFuture<AddBasketResponse> {
        guard let body = try? req.content.decode(AddBasketRequest.self) else {
            throw Abort(.badRequest)
        }
        
        let userBasket = UserBasket(productId: body.id_product, quantity: body.quantity, name: CatalogDataDirectory.shared.getNameById(id: body.id_product))
        UserData.shared.userBasket.append(userBasket)
        
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
        // очищаем корзину
        UserData.shared.userBasket = []
        
        // возвращаем успех
        let response = PayBasketResponse(result: 1, errorMessage: nil)
        return req.eventLoop.future(response)
    }
    
    
}
