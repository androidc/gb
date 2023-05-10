//Created by chizztectep on 10.05.2023

// v 1.0.0

import Foundation
import SwiftUI

struct NewsView: View {
    @State private var news: [News] = [
        News(header: "news1",text: "News1 text"),
        News(header: "news2",text: "News2 text"),
        News(header: "news3",text:"News3 text"),
        News(header: "news4",text: "News4 text")
    ]
    
    var body: some View {
        List(news){new in
            VStack{
                Text(new.header)
                    .padding()
                Text(new.text)
                    .padding()
            }
          
           // NavigationLink(destination: ForecastView(city: city)) {
              //      CityView(city: city)
           // }
        }
        .navigationBarTitle("News",displayMode: .inline)
        .listStyle(.insetGrouped)
    }
    
    
}
