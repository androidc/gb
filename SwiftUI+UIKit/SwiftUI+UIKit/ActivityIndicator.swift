//Created by chizztectep on 30.05.2023 

import UIKit
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    @Binding var isOn: Bool
   // var isOn: Binding<Bool>
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        //.init()
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.color = .orange
        indicator.startAnimating()
        return indicator
    }
    
    // вызывается каждый раз когда меняется Binding
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        print("update execute")
        
        if isOn {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
        
    }
    
    
    
    
    
    
}
