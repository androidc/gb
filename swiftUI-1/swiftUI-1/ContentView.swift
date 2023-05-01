//Created by chizztectep on 29.04.2023 

import SwiftUI

struct ContentView: View {
    @State var isOn: Bool = false
    
//    var body: some View {
//        Text("Hello, world!")
//            .padding()
//            .background(.red)
//            .introspect()
//    }
//    var body: some View {
//        VStack {
//            Text("Hello, world!")
//                .padding()
//                .background(.red)
//                .introspect()
//            Text("Hello, SwiftUI")
//            Button {
//                buildString()
//            } label: {
//                HStack {
//                    Text("Press me")
//                    Image(systemName: "moon")
//                }
//            }
//        }
//
//    }
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .foregroundColor(isOn ? .red : .blue)
            Text("Hello, SwiftUI")
                .decorateText()
            Button {
                isOn.toggle()
            } label: {
                HStack {
                    Text("Toggle")
                    Image(systemName: "moon")
                }
            }
        }
       
    }
    
    func buildString()   {
     let string1 = StringBuilder.buildBlock("Line 1","Line 2")
     let string =  String {
            "Line 1"
         if Bool.random() {
             "Line 3"
         } else {
             "Line 2"
         }
            
        }
        print(string)
        print(string1)
    }
    
   
}


extension View {
    func introspect() -> Self {
        print("type is ", type(of: self))
        return self
    }
}

struct customModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.orange)
    }
}
@resultBuilder
struct StringBuilder {
    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: "\n")
    }
    
    static func buildEither(first component: String) -> String {
        component
    }
    
    static func buildEither(second component: String) -> String {
        component
    }
}

extension View {
    func decorateText() -> some View {
        self
            .modifier(customModifier())
    }
}

extension String {
    init(@StringBuilder content: () -> String) {
        self.init(content())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
