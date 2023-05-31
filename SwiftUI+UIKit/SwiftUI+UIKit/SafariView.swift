//Created by chizztectep on 31.05.2023 

import Foundation
import SafariServices
import SwiftUI

struct SafariController: UIViewControllerRepresentable {
   
    
    
    @Binding var isOn:Bool
    
    typealias UIViewControllerType = SFSafariViewController
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let controller = SFSafariViewController(url: .init(string: "https://gb.ru")!)
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> Coordinator {
        .init(isOn: _isOn)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        private var isOn: Binding<Bool>
      
        init(isOn: Binding<Bool>) {
            self.isOn = isOn
        }
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            isOn.wrappedValue = false
        }
    }
    
   
    
    
    
    
    
    
}
