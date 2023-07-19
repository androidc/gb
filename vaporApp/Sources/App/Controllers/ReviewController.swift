//Created by chizztectep on 25.06.2023 


import Vapor

class ReviewController {

    func getReviews(_ req: Request) throws -> EventLoopFuture<[GetReviewsResponse]> {
                guard let body = try? req.content.decode(GetReviewsRequest.self) else {
                    throw Abort(.badRequest)
                }
        
        
        switch body.id_product {
            case 123:  var response: [GetReviewsResponse] = []
            response.append(GetReviewsResponse(
                id_user: 1,
                id_comment: 1,
                text: "Норм",
                errorMessage: nil
            ))
            
            response.append(GetReviewsResponse(
                id_user: 2,
                id_comment: 1,
                text: "Так себе",
                errorMessage: nil
            ))
            
            return req.eventLoop.future(response)
        case 456: var response: [GetReviewsResponse] = []
            response.append(GetReviewsResponse(
                id_user: 1,
                id_comment: 1,
                text: "Хорошая мышка",
                errorMessage: nil
            ))
            
            response.append(GetReviewsResponse(
                id_user: 2,
                id_comment: 1,
                text: "Плохая мышка",
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
    
    func addReviews(_ req: Request) throws -> EventLoopFuture<AddReviewsResponse> {
        guard let body = try? req.content.decode(AddReviewsRequest.self) else {
            throw Abort(.badRequest)
        }
        
        switch body.id_user {
        case 123: let response = AddReviewsResponse(result: 1, userMessage: "Ваш отзыв был передан на модерацию")
            return req.eventLoop.future(response)
        default:
            let response = AddReviewsResponse(result: 0, userMessage: "", errorMessage: "мы вас не знаем, идите нахер отсюда")
            return req.eventLoop.future(response)
        }
    }
    
    func removeReview(_ req: Request) throws -> EventLoopFuture<RemoveReviewResponse> {
        guard let body = try? req.content.decode(RemoveReviewRequest.self) else {
            throw Abort(.badRequest)
        }
        
        let response = RemoveReviewResponse(result: 1, errorMessage: nil)
        return req.eventLoop.future(response)
        
        
    }
}
