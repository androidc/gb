//Created by chizztectep on 10.05.2023 

import Foundation
import SwiftUI


struct ForecastView: View {
let city: City
@State var weathers = [
Weather(temperature: 15, date: Date(), icon: ""),
Weather(temperature: 16, date: Date(), icon: ""),
Weather(temperature: 17, date: Date(), icon: ""),
Weather(temperature: 18, date: Date(), icon: "")
]
var body: some View {
    
    Text(String(weathers[0].temperature))
//    ASCollectionView(data: viewModel.detachedWeathers) { (weather, context) in
//        return WeatherView(weather: weather)
//}.layout {
//.grid(
//layoutMode: .fixedNumberOfColumns(2),
//itemSpacing: 0,
//lineSpacing: 16)
//}.navigationBarTitle(viewModel.city.name)
}
}
struct WeatherView: View {
let weather: Weather
var body: some View {
    Text(String(weather.temperature))
}
}
