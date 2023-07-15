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
        
        response.append(CatalogDataResponse(
            id_product: 999,
            product_name: "Новый товар",
            price: -1
        ))
        
        return req.eventLoop.future(response)
    }
    
    func getProduct(_ req: Request) throws -> EventLoopFuture<ProductDataResponse> {
      
        guard let body = try? req.content.decode(ProductDataRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        var response: ProductDataResponse?
        
        if body.id_product == 123 {
             response = ProductDataResponse(
                result: 1,
                product_name: "Ноутбук",
                product_price: 45600,
                product_description: "Мощный игровой ноутбук",
                errorMessage: nil
            )
        }
        if body.id_product == 456 {
            
             response = ProductDataResponse(
                result: 1,
                product_name: "Мышка",
                product_price: 1000,
                product_description: "Обычная мышка",
                errorMessage: nil
            )
        }
        
        if body.id_product == 999 {
            response = ProductDataResponse(
               result: 1,
               product_name: "Новый товар",
               product_price: -1,
               product_description: "Что-то новенькое",
               errorMessage: nil
           )
        }
        
        return req.eventLoop.future(response ?? ProductDataResponse(result: 0, product_name: "Нет такого продукта", product_price: 0, product_description: "error"))
        
    }
}
