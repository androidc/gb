//Created by chizztectep on 10.05.2023 

import Foundation
import SwiftUI



struct Item:Identifiable {
  let id: UUID = UUID()
  let header: String
  //let footer: String
  let rows: [Friend]
}

struct FriendsView: View {
    
    @State private var friends: [Friend] = [
        Friend(name: "afriend1"),
        Friend(name: "cfriend5"),
        Friend(name: "afriend2"),
        Friend(name: "bfriend3"),
        Friend(name: "bfriend4")
    ]
    
    func viewModel(friends: [Friend]) -> [Item] {
        var items = [Item]()
        var groupedFriends = [[Friend]]()
        for friend in friends {
            let firstChar = String(friend.name.prefix(1))

            var found = false
            for i in 0..<groupedFriends.count {
                if groupedFriends[i][0].name.prefix(1) == firstChar {
                    groupedFriends[i].append(friend)
                    found = true
                    break
                }
            }
            
            if !found {
                groupedFriends.append([friend])
            }

        }
        
        for groupedFriend in groupedFriends {
            let item = Item(header: String(groupedFriend.first?.name.prefix(1) ?? "X"), rows: groupedFriend)
            items.append(item)
        }
        
       
        return items
    }
    
    var body: some View {
    var items: [Item] = viewModel(friends: friends)
        
      NavigationView {
        List {
            ForEach(items.sorted(by: { $0.header < $1.header })) { item in
            Section(header: Text(item.header)) {
              ForEach(item.rows) { row in
                  NavigationLink(destination: FriendsPage(friendName: row.name)) {
                      Text(row.name)
                  }
              }
            }
          }
        }
      }.listStyle(GroupedListStyle())
    }
    
}
