//
//  TabScreen.swift
//  Service It
//
//  Created by Rifatul Islam on 4/6/23.
//

import SwiftUI

struct TabScreen: View {
    @State var user_id : String
    
    var body: some View {
        TabView{
            HomeScreen(user_id: self.user_id)
                .tabItem() {
                    Image(systemName: "square.split.2x2")
                    Text("Home")
                }
            AllShopScreen(user_id: self.user_id)
                .tabItem() {
                    Image(systemName: "square.stack")
                    Text("All Shops")
                }
            History(user_id: self.user_id)
                .tabItem() {
                    Image(systemName: "list.bullet")
                    Text("History")
                }
        }
        .onAppear {
            if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
            debugPrint("tab screen \(user_id)")
        }
        .tint(.blue)
        .navigationBarBackButtonHidden(true)
    }
}

struct TabScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabScreen(user_id: "0")
    }
}
