//Created by chizztectep on 31.05.2023 

import Foundation
import SwiftUI

struct Switcher: UIViewRepresentable {
   
    @Binding var isOn: Bool
    
    
    typealias UIViewType = UISwitch
    
//    func makeUIView(context: Context) -> UISwitch {
//        .init()
//    }
    
    func makeUIView(context: Context) -> UISwitch {
        let switcher = UISwitch()
        switcher.addTarget(context.coordinator, action: #selector(Coordinator.toggle(_:)), for: .allEvents)
        return switcher
    }
    
    func updateUIView(_ uiView: UISwitch, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        .init(parent: self)
    }
    
    
    class Coordinator {
        private var parent: Switcher
        
        init(parent: Switcher){
            self.parent = parent
        }
        
        @objc func toggle(_ view: UISwitch) {
            parent.isOn = view.isOn
        }
    }
    
    
}
