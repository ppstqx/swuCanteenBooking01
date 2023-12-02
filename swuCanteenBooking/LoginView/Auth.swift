//
//  Auth.swift
//  swuCanteenBooking
//
//  Created by xqst on 22/11/2566 BE.
//

import SwiftUI
import FirebaseAuth

struct Auth: View {
    @State private var currentViewShowing: String = "login" // login or sign up
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            if currentViewShowing == "login" {
                LoginView(currentShowingView: $currentViewShowing, isLoggedIn: $isLoggedIn)
            } else {
                SignupView(isLoggedIn: $isLoggedIn, currentShowingView: $currentViewShowing)
                    .onAppear {
                        // Navigate to HomeView when isLoggedIn is true
                        //                               if isLoggedIn {
                        currentViewShowing = "home"
                    }
            
    }
               }
//        .onChange(of: isLoggedIn) { newIsLoggedIn in
//            if newIsLoggedIn && currentViewShowing != "home" {
//                currentViewShowing = "home"
//            }
//        }

//               .fullScreenCover(isPresented: $isLoggedIn, content: {
//                   HomeView()
//               })
           }
       }
#Preview {
    Auth(isLoggedIn: .constant(false))
}
