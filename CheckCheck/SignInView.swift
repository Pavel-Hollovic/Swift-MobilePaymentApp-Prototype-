//
//  SignInView.swift
//  CheckCheck
//
//  Created by Pavel Hollovic on 23.03.2021.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var coordinator: SignInWithAppleCoordinator?
    
    var body: some View {
        VStack {
            Text("Welcome to CheckCheck. Please Sign in here.")
            SignInWithAppleButton()
                .frame(width: 200, height: 45)
                .onTapGesture {
                    self.coordinator = SignInWithAppleCoordinator()
                    if let coordinator = self.coordinator {
                        coordinator.startSignInWithAppleFlow {
                            print("You succesfully signed in")
                            
                            self.presentationMode.wrappedValue.dismiss()//dismiss this view after taping this button
                        }
                    }

                }
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
