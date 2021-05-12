//
//  SignInWithAppleButton.swift
//  CheckCheck
//
//  Created by Pavel Hollovic on 23.03.2021.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInWithAppleButton: UIViewRepresentable { //this is used to wrappp ui components and use then in new SwiftUI. Apple Button not yet aviable?
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}

