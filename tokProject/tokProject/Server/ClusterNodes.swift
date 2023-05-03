//Created by chizztectep on 03.05.2023 

import Foundation

class ClusterNodes {
    var nodes: [Node] = []
//    let mail: String = "123"
//    let pass: String = "123"
    let mail: String = "admin"
    let pass: String = "admin"
    
    func addNode() {
        let node = Node(mail: mail, password: pass)
        nodes.append(node)
    }
    
    func removeNodeByIndex(index: Int) {
        nodes.remove(at: index)
    }
    
    func performRequestOnNode(index: Int) -> String? {
        do  {
            let result = try nodes[index].performRequest()
            return result
        } catch tokenError.noToken {
            print("no Token")
            return nil
        } catch tokenError.wrongMailPass {
            print("wrongMailPass")
            return nil
        } catch tokenError.longBlocking {
            print("longBlocking")
            return nil
        } catch {
            print("unknownException")
            return nil
        }
    }
    
    
}
