//Created by chizztectep on 10.05.2023 

import Foundation
import SwiftUI




struct CitiesView: View {
    @State private var cities: [City] = [
        City(name: "Kazan", imageName: "kazan"),
        City(name: "Cheboksary", imageName: "cheboksary"),
        City(name: "Vladivostok", imageName: "vladivostok"),
        City(name: "Yaroslavl", imageName: "yaroslavl")
    ]
    
    var body: some View {
        List(cities.sorted(by: {$0.name < $1.name})){city in
            
            Text(city.name)
           // NavigationLink(destination: ForecastView(city: city)) {
              //      CityView(city: city)
           // }
        }
        .navigationBarTitle("Cities",displayMode: .inline)
    }
    
}
