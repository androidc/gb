//Created by chizztectep on 02.05.2023 

import Foundation

protocol Mediator: AnyObject {
    var strategy: MediatorStrategy { get set }
    func sendRequest()
}

class DispatcherMediator: Mediator {
    
    var strategy: MediatorStrategy
    var cluster: ClusterNodes
    var currentNode: Int = 0
    let queue = DispatchQueue.global(qos: .utility)
   
   
    
 
    init(strategy: MediatorStrategy, claster: ClusterNodes) {
        self.strategy = strategy
        self.cluster = claster
    }
    
    // some changes
    
    func sendRequest()  {
        // передать сообщение в одну из нод, выбор ноды по стратегии.
       // print("mediator send request")
        switch strategy {
        case .consistent:
            print("send request using consistent strategy")
           
            queue.async {
                let nodesCount = self.cluster.nodes.count
                if (self.currentNode >= nodesCount) { self.currentNode = 0 }
                let id = UUID().uuidString
                print(self.cluster.performRequestOnNode(index: self.currentNode, id: id))
                // эта строчка выполняется после того, как выполнится предыдущая, то есть пройдет один из запросов, поэтому наполняется сначала первая нода
                self.currentNode+=1
            }
          
            
            
        case .random:
            print("send request using random strategy")
        case .byDisp:
            print("send request byDisp")
        }
        
    }
}


