//Created by chizztectep on 02.05.2023 

import UIKit

class ViewController: UIViewController {
    var client: Client?
    let queue = DispatchQueue.global(qos: .utility)
    
    //MARK: - Outlets
    
    @IBAction func sendAction(_ sender: UIButton) {
        print("tap button")
        client?.sendRequest()
    }
    
    @IBAction func lockUnlockAction(_ sender: Any) {
        TokenShare.shared.isLocked.toggle()
        print(TokenShare.shared.isLocked)
    }
    
    @IBAction func changeTokenAction(_ sender: Any) {
        cluster.service.token =  UUID().uuidString
    }
    
    @IBOutlet weak var tokenApi: UILabel!
    
    @IBOutlet weak var tokenDB: UILabel!
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //private properties
    private var nodesWorkers:[Int] = []
   
    //MARK: - Properties
    
    var cluster: ClusterNodes = ClusterNodes()
    
    
    // MARK: - Main
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        // инициализируем кластер двумя нодами
        cluster.addNode()
        nodesWorkers.append(0)
        cluster.addNode()
        nodesWorkers.append(0)
        cluster.addNode()
        nodesWorkers.append(0)
        cluster.addNode()
        nodesWorkers.append(0)
        
        
        // инициализируем медиатор c последовательной отправкой сообщений в ноды
        let mediator = DispatcherMediator(strategy: .consistent, claster: cluster)
        client = Client(mediator: mediator)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
              // асинхронно спрашиваем сервисы и возвращаем completion
                self.monitor { nodesWorkers in
                    for (index, worker) in nodesWorkers.enumerated() {
                        print("\(index) worker have \(worker) threads ")
                    }
                    
                    self.tokenApi.text = "Токен API: \(self.cluster.service.token)"
                    self.tokenDB.text = "Токен в БД: \(TokenShare.shared.token)"
                    
                    self.tableView.reloadData()
                }
            }
       
        // при интервали 0.05 перестает обновляться экран
        // до второго таймера не доходит даже
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.client?.sendRequest()
        }
        
      
        
        
        
        
    }
    
    // MARK: private functions
   
    private func monitor( completion: @escaping ([Int]) -> Void) {
        
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global(qos: .default).async {
            // получаем количество потоков на нодах с статусом running
            for (index,node) in self.cluster.nodes.enumerated() {
               // self.nodesWorkers.append(node.workers.filter{ $0.workerStatus == .running}.count)
                self.nodesWorkers[index] = node.workers.filter{ $0.workerStatus == .running}.count
                // удаляем worker .finished
                if node.workers.contains(where: { $0.workerStatus == .finished
                }) {
                    node.lock.with{node.workers.removeAll {$0.workerStatus == .finished }}
                }
                
            }
            
            group.leave()
        }
        group.notify(queue: .main) {
            completion(self.nodesWorkers)
        }
        
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cluster.nodes.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        
       // let record = Game.shared.records[indexPath.row]
        cell.textLabel?.text = "Node \(indexPath.row)"
        if nodesWorkers.count > 0 {
            cell.detailTextLabel?.text = "threads: \(nodesWorkers[indexPath.row])"
            
        }
        return cell
    }
    
    
}

