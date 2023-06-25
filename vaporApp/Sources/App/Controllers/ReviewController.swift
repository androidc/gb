//Created by chizztectep on 25.06.2023 


import Vapor

class ReviewController {

    func getReviews(_ req: Request) throws -> EventLoopFuture<[GetReviewsResponse]> {
                guard let body = try? req.content.decode(GetReviewsRequest.self) else {
                    throw Abort(.badRequest)
                }
        
        
        switch body.id_product {
            case 1:  var response: [GetReviewsResponse] = []
            response.append(GetReviewsResponse(
                id_user: 1,
                id_comment: 1,
                text: "Норм",
                errorMessage: nil
            ))
            
            response.append(GetReviewsResponse(
                id_user: 1,
                id_comment: 1,
                text: "Говно",
                errorMessage: nil
            ))
            
            return req.eventLoop.future(response)
         default:
            var response: [GetReviewsResponse] = []
            response.append(GetReviewsResponse(
                id_user: 0,
                id_comment: 0,
                text: "",
                errorMessage: "нет такого товара"
            ))
            return req.eventLoop.future(response)
        }
        
       
        
    }
}
