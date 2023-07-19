import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    
    
    let controller = AuthController()
    app.post("registerUser.json",use: controller.register)
    app.post("login.json",use: controller.login)
    app.post("logout.json",use: controller.logout)
    
    let clientController = ClientController()
    
    app.post("changeUserData.json",use: clientController.changeClient)
    
    let catalogController = CatalogController()
    app.post("catalogData.json",use: catalogController.getCatalog)
    app.post("getGoodById.json",use: catalogController.getProduct)
    
    let reviewController = ReviewController()
    app.post("getReviews.json",use: reviewController.getReviews)
    app.post("addReview.json",use: reviewController.addReviews)
    app.post("removeReview.json",use: reviewController.removeReview)
    
    let basketController = BasketController()
    app.post("addBasket.json",use: basketController.addBasket)
    app.post("removeBasket.json", use: basketController.removeBasket)
    app.post("payBasket.json", use: basketController.payBasket)
    app.post("getBasket.json", use: basketController.getBasket)

    try app.register(collection: TodoController())
}
