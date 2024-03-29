//Created by chizztectep on 30.05.2023 

import SwiftUI

struct ContentView: View {
    @State var isOn: Bool = false
    
    var body: some View {
        
        if isOn {
            SafariController(isOn: $isOn)
        } else {
        VStack {
            Button{
                isOn.toggle()
            }label: {
                Text(isOn ? "Turn off": "Turn on")
            }
            Switcher(isOn: $isOn)
            SwitcherOnAction(isOn: $isOn)
            ActivityIndicator(isOn: $isOn)
            
        }
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
