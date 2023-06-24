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

    try app.register(collection: TodoController())
}
