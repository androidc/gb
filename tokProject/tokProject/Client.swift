//Created by chizztectep on 02.05.2023 

import Foundation



class Client {
    
    private  var mediator: Mediator?
    
    init(mediator: Mediator) {
        self.mediator = mediator
    }
    
    func sendRequest() {
        print("call mediator")
        self.mediator?.sendRequest()
        
    }
    
}
