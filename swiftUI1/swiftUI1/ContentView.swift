//Created by chizztectep on 01.05.2023

// v 1.0.0
// v 1.0.1

import SwiftUI

struct ContentView: View {
    @State var login = ""
    @State var pass = ""
    @State private var showIncorrentCredentialsWarning = false
    @Binding var isUserLoggedIn: Bool
    @CodingStyle(codingStyle: .camelCase) var welcomeString = "welcome to moscow"
    @CodingStyle(codingStyle: .kebabCase) var enterLogin = "Введите логин"
    @CodingStyle(codingStyle: .snakeCase) var enterPass = "Введите пароль"
    
    var body: some View {
        
        VStack {
            Image("logo").resizable().scaledToFit()
                .padding()
            Text(welcomeString)
                .padding()
            TextField(enterLogin, text: $login)
                .padding()
            TextField(enterPass, text: $pass)
                .padding()
            Button {
               verifyLoginData()
            } label: {
                Text("Войти")
            }
            
        } .alert(isPresented: $showIncorrentCredentialsWarning) {
            Alert(title: Text("Error"), message: Text("Incorrent Login/Password was entered"))
        }
        
     
    }
    
    private func verifyLoginData() {
    if login == "111" && pass == "111" {
    // authorizing user
        isUserLoggedIn = true
        } else {
                showIncorrentCredentialsWarning = true
                }
        // сбрасываем пароль, после проверки для лучшего UX
        pass = ""
    }
}




//struct ContentView_Previews: PreviewProvider {
//   
//    static var previews: some View {
//        ContentView(isUserLoggedIn: Binding<Bool>)
//    }
//}
