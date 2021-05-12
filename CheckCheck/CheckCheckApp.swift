//
//  CheckCheckApp.swift
//  CheckCheck
//
//  Created by Pavel Hollovic on 14.02.2021.
//

import SwiftUI
import Firebase

@main
struct CheckCheckApp: App {
    init(){
        FirebaseApp.configure() //firebase sdk initilazer. not enough for Cloud messaging
//        if Auth.auth().currentUser == nil {//check if user is alredy sign in if not anonymous sign in
//            Auth.auth().signInAnonymously()//with the start of app we call anonymous sign in
        }
    
    var body: some Scene {
        WindowGroup {
                ContentView().environmentObject(SessionStore())
            }
    }
}
