//Created by chizztectep on 10.05.2023 

import Foundation
import SwiftUI

struct GroupsView: View {
    @State private var groups: [Groups] = [
        Groups(name: "group1"),
        Groups(name: "group2"),
        Groups(name: "group4"),
        Groups(name: "group5")
    ]
    
    var body: some View {
        List(groups.sorted(by: {$0.name < $1.name})){group in
            
            Text(group.name)
           // NavigationLink(destination: ForecastView(city: city)) {
              //      CityView(city: city)
           // }
        }
        .navigationBarTitle("Groups",displayMode: .inline)
    }
    
    
}
