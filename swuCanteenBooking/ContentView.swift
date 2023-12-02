//
//  ContentView.swift
//  swuCanteenBooking
//
//  Created by xqst on 18/11/2566 BE.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct ContentView: View {
    @AppStorage("uid") var userID: String = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        Group {
            if isLoggedIn {
                Tabbar()
            } else {
                NavigationView {
                    AuthView(isLoggedIn: $isLoggedIn, userID: $userID)
                }
            }
        }
    }
}




#Preview {
    ContentView()
}
