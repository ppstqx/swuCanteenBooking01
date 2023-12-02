//
//  ProfileView.swift
//  swuCanteenBooking
//
//  Created by xqst on 1/12/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ProfileView: View {
    @State private var isLoggedOut = false

    var body: some View {
        NavigationView {
                   ScrollView(.vertical, showsIndicators: false) {
                       HStack {
                           Spacer()
                       }
                       .overlay(
                           Text("Profile")
                               .font(.title2)
                               .fontWeight(.semibold)
                       )
                       .padding()
                       .padding(.top, 10)
                       

                       Button(action: {
                           do {
                               try Auth.auth().signOut()
                               isLoggedOut = true
                           } catch {
                               print("Error signing out: \(error.localizedDescription)")
                           }
                       }) {
                           Text("Log Out")
                               .font(.headline)
                               .foregroundColor(.black)
                               .padding()
                               .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
                       }
                       .padding()
                       .fullScreenCover(isPresented: $isLoggedOut) {
                           AuthView(isLoggedIn: .constant(false), userID: .constant(""))
                       }
                   }
                   .background(Color.white)
               }
           }
       }


#Preview {
    ProfileView()
}
