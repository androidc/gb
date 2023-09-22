//Created by chizztectep on 22.09.2023 

import SwiftUI
import Combine

enum StaticVars {
    static let byButton = 1
    static let byAction = 0
}
struct ContentView: View {
    @State private var start_stop = false
    @State private var showAlert = false
    @State private var number: Int = 10
    var apiClient = APIClient()
    @State var subscriptions : Set<AnyCancellable> = []
    @State var link1 = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
    @State var link2 = "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
    @State var link3 = "https://rickandmortyapi.com/api/character/avatar/3.jpeg"
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    var buttonCaption: String {
        start_stop ? "Stop" : "Start"
    }
    var body: some View {
        VStack{
            HStack {
                AsyncImage(url: URL(string: link1),scale: 2.5)
                AsyncImage(url: URL(string: link2),scale: 2.5)
                AsyncImage(url: URL(string: link3),scale: 2.5)
            }.padding(10)
            Button(buttonCaption){
               
                start_stop.toggle()
                if start_stop {
                    self.startTimer()
                } else {
                    self.stopTimer(reason: StaticVars.byButton)
                }
       
            }
            
            Stepper("Max random avatars: \(Int(number))",
                               value: $number,
                               in: 0...100,
                               step: 1)
         }
    }
    
    
    func stopTimer(reason: Int) {
           self.timer.upstream.connect().cancel()
        
       }
       
       func startTimer() {
           self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
           timer
           .sink { _ in
              let id1 = randomImage(imgPos: 1)
              let id2 = randomImage(imgPos: 2)
              let id3 = randomImage(imgPos: 3)
               if id1 == id2, id2 == id3 {
                   stopTimer(reason: StaticVars.byAction)
               }
           }
          .store(in: &subscriptions)
           
       }
    
    
    func randomImage(imgPos: Int) -> Int {
       let id = Int.random(in: 1..<number)
       let publisher =  apiClient.avatar(id: id)
              //.print()
              .receive(on: DispatchQueue.global())
              .map{$0.image}
              
        
        let sub = publisher
            .receive(on: DispatchQueue.global())
             .sink { _ in
                 print("finished")
             } receiveValue: {
                 switch imgPos {
                 case 1: self.link1 = $0
                 case 2: self.link2 = $0
                 case 3: self.link3 = $0
                 default: print("undefined image position")
                 }
             }
             .store(in: &subscriptions)
        
        return id
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
