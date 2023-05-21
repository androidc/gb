//Created by chizztectep on 10.05.2023

// v 1.0.0

import Foundation
import SwiftUI

struct ContainerView: View {
    @State private var shouldShowMainView: Bool = false

    
    var body: some View {
        NavigationView {
            HStack {
                ContentView(isUserLoggedIn: $shouldShowMainView)
                NavigationLink(destination: TabsView(), isActive: $shouldShowMainView) {
                    EmptyView()
                }
                
                
                
            }
        }
    }
}

