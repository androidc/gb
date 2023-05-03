//Created by chizztectep on 01.05.2023 

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(systemName: "star")
            .resizable()    
            .background(.red)
            .frame(width: 100, height: 100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
