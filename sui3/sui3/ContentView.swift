//Created by chizztectep on 03.05.2023 

import SwiftUI

struct ContentView: View {
    @State var showAlert: Bool = false
    @State var itemForSheet: Int?
    
//    var body: some View {
//        Text("Hello, world!")
//            .padding()
//            .alert(isPresented: $showAlert) {
//            .init(title: Text("Alert"))
//            }
//            .onTapGesture {
//                showAlert = true
//                }
//            .onChange (of: showAlert) { newValue in
//                print("alert value is \(newValue)")
//            }
//
//    }
    
    var body: some View {
        NavigationView {
        VStack {
            Text("Hello, world!")
                .onTapGesture {
                            showAlert = true
                    }
            Button{
                itemForSheet = (1...9).randomElement()
                    } label: {
                        Text("show sheet")
                    }
            
            NavigationLink {
                Image(systemName: "moon")
                    .resizable()
                    .foregroundColor(.red)
                    .background(.blue.opacity(0.25))
            }  label: {
                HStack {
                    Text("Go to the Moon")
                    Spacer()
                    Image(systemName: "moon")
                }
            }
            
            
        }
                .alert(isPresented: $showAlert) {
                .init(title: Text("Alert"))
                }
                .onChange (of: showAlert) { newValue in
                    print("alert value is \(newValue)")
                }
                .actionSheet(item: $itemForSheet) { item in
                    ActionSheet(title: .init("Title"), message: .init("Message"), buttons: [
                        .default(Text("Button")),
                        .cancel()
                        
                    ])
                }
        }
        

  

    }
}

extension Int:Identifiable {
    public var id: Int {
        self
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
