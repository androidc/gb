//Created by chizztectep on 10.05.2023

// v 1.0.0

import Foundation
import SwiftUI


struct TabsView: View {
    var body: some View {
        TabView {
            FriendsView()
                .tabItem {
                    Label("Friends",systemImage: "person")
                }
            GroupsView()
                .tabItem {
                    Label("Groups",systemImage: "folder")
                }
            NewsView()
                .tabItem {
                    Label("News",systemImage: "newspaper")
                }
        }
    }
}
