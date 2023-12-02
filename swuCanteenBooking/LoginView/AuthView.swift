//
//  AuthView.swift
//  swuCanteenBooking
//
//  Created by xqst on 22/11/2566 BE.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
        @State private var currentViewShowing: String = "login" // login or sign up
        @Binding var isLoggedIn: Bool
          @Binding var userID: String

        var body: some View {
            NavigationView {
                if currentViewShowing == "login" {
                    LoginView(currentShowingView: $currentViewShowing, userID: $userID, isLoggedIn: $isLoggedIn)
                } else {
                    SignupView(userID: $userID, isLoggedIn: $isLoggedIn, currentShowingView: $currentViewShowing)
                        .onAppear {
                            // Navigate to HomeView when isLoggedIn is true
                            //                               if isLoggedIn {
                            currentViewShowing = "home"
                        }
                
        }
                   }
               }
           }

#Preview {
    AuthView(isLoggedIn: .constant(false), userID: .constant(""))
}
