//
//  ContentView.swift
//  CheckCheck
//
//  Created by Pavel Hollovic on 19.04.2021.
//

import SwiftUI
import Firebase
import Combine

final class SessionStore: ObservableObject {
    @Published var session: User?
    var handle: AuthStateDidChangeListenerHandle?

    func listen() {
        handle =  Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.session = user
            } else {
                self.session = nil
            }
        }
    }
}


struct ContentView: View {
    @EnvironmentObject private var session: SessionStore
    
    var body: some View {
        
        Group {
            if session.session != nil {//check if user is alredy sign in if not anonymous sign in
                MainScreenView()
            }
            else{
                SignInView()
            }
        }.onAppear(perform: {self.session.listen()})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
