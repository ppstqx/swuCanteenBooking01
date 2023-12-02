//
//  LoginView.swift
//  swuCanteenBooking
//
//  Created by xqst on 22/11/2566 BE.
//


import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var currentShowingView: String 
    @Binding var userID: String
    @Binding var isLoggedIn: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSecure = true
    

    
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
                    Text("Welcome!")
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
                HStack {
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
                    withAnimation {
                        self.currentShowingView = "signup"
                    }
                    
                }) {
                    Text("Don't have an account ?")
                        .foregroundColor(.black.opacity(0.7))
                }

                
                
                Spacer()
                Spacer()
                
                Button {
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                       print(error)
                       return
                                           }
                                           
                        if let authResult = authResult {
                            print(authResult.user.uid)
                                withAnimation {
                                userID = authResult.user.uid
                                 isLoggedIn = true
                  }
                        }
          }
                    
                } label: {
                    Text("Sign In")
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
   
