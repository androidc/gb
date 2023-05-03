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
   
    
 
    init(strategy: MediatorStrategy, claster: ClusterNodes) {
        self.strategy = strategy
        self.cluster = claster
    }
    
    
    
    func sendRequest() {
        // передать сообщение в одну из нод, выбор ноды по стратегии.
        print("mediator send request")
        switch strategy {
        case .consistent:
            print("send request using consistent strategy")
            let nodesCount = cluster.nodes.count
            if (currentNode >= nodesCount) { currentNode = 0 }
            print(cluster.performRequestOnNode(index: currentNode))
            currentNode+=1
        case .random:
            print("send request using random strategy")
        case .byDisp:
            print("send request byDisp")
        }
        
    }
}
