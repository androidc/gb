//Created by chizztectep on 12.09.2023 

import Combine

class MySubscriber: Subscriber {
  
    
    typealias Input = Int
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.max(3))
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        let modifiedValue = input*2
        print("modified ",modifiedValue)
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Receive completion", completion)
    }
    
    
    
}
