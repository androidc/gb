//Created by chizztectep on 04.06.2023 

import UIKit
import SwiftUI

class ViewController: UIViewController {

    let swiftUIView = UIHostingController(rootView: CustomUI())
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        addChild(swiftUIView)
        view.addSubview(swiftUIView.view)
        swiftUIView.didMove(toParent: self)
        
        swiftUIView.view.translatesAutoresizingMaskIntoConstraints = false
        [
        swiftUIView.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        swiftUIView.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)].forEach { $0.isActive = true
        }
        
        
        
         
    }


}

