//
//  SignupView.swift
//  swuCanteenBooking
//
//  Created by xqst on 22/11/2566 BE.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var userID: String
    @Binding var isLoggedIn: Bool
    @Binding var currentShowingView: String

    // minimun 6characters long
    // 1 uppercase character
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z]).{6,}$")
        
        return passwordRegex.evaluate(with: password)
    }

    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Create an account")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
                .padding()
                .padding(.top)
                
                
                Spacer()
                
                HStack{
                    Image(systemName: "mail")
                    TextField("Email", text: $email)
                    
                    Spacer()
                    
                    if (email.count != 0) {
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .foregroundColor(email.isValidEmail() ? .green : .red)
                            .fontWeight(.bold)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                )
                .padding()
                
                HStack{
                    Image(systemName: "lock")
                    SecureField("Password", text: $password)
                    
                    Spacer()
                    if password.count != 0 {
                        Image(systemName: isValidPassword(password) ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(isValidPassword(password) ? .green : .red)
                    }

                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                )
                .padding()
                Button(action: {
                    withAnimation{
                        self.currentShowingView = "login"
                    }
                }) {
                    Text("Already have an account ?")
                        .foregroundColor(.black.opacity(0.7))
                }

                
                
                Spacer()
                Spacer()
                
                Button {
                    
                    
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        if let authResult = authResult {
                            print(authResult.user.uid)
                            userID = authResult.user.uid
                            isLoggedIn = true
                        }
                    }
                    
                } label: {
                    Text("Create New Account")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    
                        .frame(maxWidth: . infinity)
                        .padding()
                    
                        .background(
                          RoundedRectangle(cornerRadius: 10)
                          .fill(Color.black)
                        )
                        .padding(.horizontal)
                }
      }
    }
  }
}

