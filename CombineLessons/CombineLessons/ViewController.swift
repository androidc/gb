//Created by chizztectep on 12.09.2023 

import UIKit
import Combine

class ViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let publisher = (1...10).publisher
        let subscriber = MySubscriber()
        publisher.subscribe(subscriber)
        
        let valueSubscriber = ValueSubscriber()
        let subject = PassthroughSubject<CurrentValueSubject<String,Never>, MyError>()
        
        subject.subscribe(valueSubscriber)
        let testCVS: CurrentValueSubject<String, Never> = .init("Hello")
        subject.send(testCVS)
        subject.send(completion: .failure(MyError.somethingWentWrong))
    }
        

}

