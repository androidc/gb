//Created by chizztectep on 31.05.2023

import Foundation
import SwiftUI

struct SwitcherOnAction: UIViewRepresentable {
   
    @Binding var isOn: Bool
    
    
    typealias UIViewType = UISwitch
    
//    func makeUIView(context: Context) -> UISwitch {
//        .init()
//    }
    
    func makeUIView(context: Context) -> UISwitch {
        let switcher = UISwitch()
        switcher.addAction(.init(handler: { action in
            if let switcher = action.sender as? UISwitch {
                isOn = switcher.isOn
            }
        }), for: .allEvents)
        return switcher
    }
    
    func updateUIView(_ uiView: UISwitch, context: Context) {}
    
 
    
}
