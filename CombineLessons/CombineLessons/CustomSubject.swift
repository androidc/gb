//Created by chizztectep on 12.09.2023 

import Combine

enum MyError: Error {
    case somethingWentWrong
}

class ValueSubscriber: Subscriber {
 
    typealias Input = CurrentValueSubject<String,Never>
    typealias Failure = MyError
   
    func receive(subscription: Subscription) {
        subscription.request(.max(2))
    }
    
    func receive(_ input: CurrentValueSubject<String, Never>) -> Subscribers.Demand {
        print(input.value)
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<MyError>) {
        print("Receive completion", completion)
    }
    
    
}
