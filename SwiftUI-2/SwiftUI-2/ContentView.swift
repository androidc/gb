//Created by chizztectep on 01.05.2023 

import SwiftUI

//В домашнем задании создайте будущую ячейку отображения фамилии пользователя, и будущую ячейку отображения группы пользователя:
//1. Создайте прототипы ячеек
//2. Используйте как можно больше модификаторов, создайте свои View, ViewModifier и ViewBuilder

struct ContentView: View {
    var surname: String = "some surname"
    var group: String = "some group"
    
    var body: some View {
//        Image(systemName: "star")
//            .resizable()
//            .background(.red)
//            .frame(width: 100, height: 100)
        
        CustomStack.init(color: .red) {
            surnameCell
            groupCell
        }
        .modifier(CustomModifier())
        .zpadding()
  
        
        
       
    }
}

extension ContentView {
    var surnameCell: some View {
        Text(surname)
            .lineLimit(1)
            .padding()
    }
    
    var groupCell: some View {
        Text(group)
            .lineLimit(1)
            .padding()
    }
}

struct CustomStack<Content: View>: View {
    let content: Content
    let color: Color
    init(color: Color = .yellow, @ViewBuilder content: ()-> Content) {
        self.color = color
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
                .font(.largeTitle)
        }
        .background(color)
    }
}

struct CustomModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
    }
}

extension View {
    func zpadding() -> some View {
        self
            .modifier(CustomModifier())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
