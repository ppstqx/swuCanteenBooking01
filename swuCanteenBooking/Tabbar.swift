//
//  Tabbar.swift
//  swuCanteenBooking
//
//  Created by xqst on 18/11/2566 BE.
//

import SwiftUI

struct Tabbar: View {
    var body: some View {
        TabView  {
                HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                        }

                BookmarkView()
                .tabItem {
                    Label("Favorites", systemImage: "bookmark")
                        }

                BookingView()
                .tabItem {
                    Label("Booking", systemImage: "list.clipboard.fill")
                        }
              ProfileView()
                .tabItem {
                    Label("Profile", systemImage:"person.fill")
                }
                }
                .accentColor(.black)   
    }
}



#Preview {
    Tabbar()
}
