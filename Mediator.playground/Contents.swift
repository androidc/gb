import UIKit

protocol Colleague: AnyObject {
    func collegueDidSendToUs(_ collegue: Colleague, didSendMessage: String)
}

protocol Mediator: AnyObject {
    func addColleague(_ colleague: Colleague)
    func sendMessage(_ message: String, by collegue: Colleague)
}


class ColleagueMediator: Mediator {
    var colleagues: [Colleague] = []
    
    func addColleague(_ colleague: Colleague) {
        colleagues.append(colleague)
    }
    
    func sendMessage(_ message: String, by collegue: Colleague) {
        for colleagueToSend in colleagues where colleagueToSend !== collegue {
            colleagueToSend.collegueDidSendToUs(collegue, didSendMessage: message)
        }
    }
}

class Person: Colleague {
  
    
    let name: String
    
    private weak var mediator: Mediator?
    
    init(name: String, mediator: Mediator) {
        self.name = name
        self.mediator = mediator
        mediator.addColleague(self)
    }
    
    func sendMessage(_ message: String) {
        print("\(name) send message \(message)")
        mediator?.sendMessage(message, by: self)
    }
    
    func collegueDidSendToUs(_ collegue: Colleague, didSendMessage: String) {
        print("\(name) did receive \(didSendMessage)")
    }
    
    
    
}


let mediator = ColleagueMediator()
let person1 = Person(name: "tolya", mediator: mediator)
let person2 = Person(name: "kolya", mediator: mediator)
let person3 = Person(name: "masha", mediator: mediator)

person1.sendMessage("hello")
print("")
person2.sendMessage("hi to you")
print("")
person3.sendMessage("i hear you")
