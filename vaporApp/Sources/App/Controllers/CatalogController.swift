//Created by chizztectep on 24.06.2023 

import Vapor

class CatalogController {
    func getCatalog(_ req: Request) throws -> EventLoopFuture<[CatalogDataResponse]> {
      
        guard let body = try? req.content.decode(CatalogDataRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        var response: [CatalogDataResponse] = []
        response.append(CatalogDataResponse(
            id_product: 123,
            product_name: "Ноутбук",
            price: 45600
        ))
        
        response.append(CatalogDataResponse(
            id_product: 456,
            product_name: "Мышка",
            price: 1000
        ))
        
        return req.eventLoop.future(response)
    }
    
    func getProduct(_ req: Request) throws -> EventLoopFuture<ProductDataResponse> {
      
        guard let body = try? req.content.decode(ProductDataRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        let response = ProductDataResponse(
            result: 1,
            product_name: "Ноутбук",
            product_price: 45600,
            product_description: "Мощный игровой ноутбук",
            errorMessage: nil
        )
        
        return req.eventLoop.future(response)
    }
}
