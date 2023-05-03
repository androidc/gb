//Created by chizztectep on 02.05.2023 

import UIKit

class ViewController: UIViewController {
    var client: Client?
    //MARK: - Outlets
    
    @IBAction func sendAction(_ sender: UIButton) {
        print("tap button")
        client?.sendRequest()
    }
    
    //private properties
    
   
    
    //MARK: - Properties
    
    var cluster: ClusterNodes = ClusterNodes()
    
    
    // MARK: - Main
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // инициализируем кластер двумя нодами
        cluster.addNode()
        cluster.addNode()
        
        // инициализируем медиатор c последовательной отправкой сообщений в ноды
        let mediator = DispatcherMediator(strategy: .consistent, claster: cluster)
        client = Client(mediator: mediator)
       // client?.sendRequest()
        
        
    }
    
    // MARK: private functions
   
   


}

