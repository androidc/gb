//Created by chizztectep on 18.09.2023 

import UIKit
import Combine

class ViewController2: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var image: UIImageView!
    
    // MARK: vars
    var api_key: String?
    let dummyPublisher: AnyPublisher<UIImage?, Never> = Empty(completeImmediately: false).eraseToAnyPublisher()
    var subscriptions = Set<AnyCancellable>()
    
    //MARK: private functions
    func getImage() -> AnyPublisher<UIImage?, Never> {
        
        guard let api_key = api_key else {return dummyPublisher}
        var request =  URLRequest(url: URL(string: "https://api.api-ninjas.com/v1/randomimage?category=nature")!)
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.addValue(api_key, forHTTPHeaderField: "x-api-key")
        request.addValue("image/jpg", forHTTPHeaderField: "Accept")
        // request.HTTPBody = try! JSONSerialization.dataWithJSONObject(parameters, options: [])
       
        return session.dataTaskPublisher(for: request)
            .map { data, _ in UIImage(data: data) }
            .print("image")
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let value = ProcessInfo.processInfo.environment["ninja_api_key"] {
            self.api_key = value
        }
        
        let taps = PassthroughSubject<Void, Never>()
        taps
            .map { _ in self.getImage() }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] in self?.image.image = $0}
            .store(in: &subscriptions)
        taps.send()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            taps.send()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.1) {
            taps.send()
        }
        
    }
}
