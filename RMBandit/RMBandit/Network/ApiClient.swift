//Created by chizztectep on 22.09.2023 

import Foundation
import Combine
import SwiftUI


struct APIClient {
    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "ApiClient",qos: .default,attributes: .concurrent)
  
    
    func avatar(id: Int)  -> AnyPublisher<AvatarInfo, Error> {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: "https://rickandmortyapi.com/api/character/\(id)")!)
            //.print()
            .receive(on: queue)
            .map(\.data)
            .decode(type: AvatarInfo.self, decoder: decoder)
            .mapError { error -> Error in
                switch error {
                case is URLError: return Error.unreachableAddress(url: URL(string: "https://rickandmortyapi.com/api/character/\(id)")!)
                default: return Error.invalidResponse
                }
            }
            .share()
            .eraseToAnyPublisher()
            
    }
}
