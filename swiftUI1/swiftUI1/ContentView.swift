//Created by chizztectep on 01.05.2023 

import SwiftUI

struct ContentView: View {
    @State var login = ""
    @State var pass = ""
    
    var body: some View {
        VStack {
            Image("logo").resizable().scaledToFit()
                .padding()
            Text("Welcome")
                .padding()
            TextField("Введите логин", text: $login)
                .padding()
            TextField("Введите пароль", text: $pass)
                .padding()
            Button {
                
            } label: {
                Text("Войти")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
