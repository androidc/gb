//Created by chizztectep on 24.06.2023 

import Vapor

class ClientController {
    func changeClient(_ req: Request) throws -> EventLoopFuture<ChangeClientResponse> {
        guard let body = try? req.content.decode(ChangeClientRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        let response = ChangeClientResponse(
            result: 1,
            errorMessage: nil
        )
        return req.eventLoop.future(response)
    }
}
