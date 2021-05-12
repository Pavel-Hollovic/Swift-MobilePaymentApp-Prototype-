//
//  MenuView.swift
//  CheckCheck
//
//  Created by Pavel Hollovic on 18.04.2021.
//

import SwiftUI
import Firebase

struct MenuView: View {
    var body: some View {
        List {
            Section(header: Text("ACCOUNT")) {
                NavigationLink(destination: TransactionListView()) {
                    Text("Transaction History")
                }
                Text("About You")
                Button(action: {
                    self.signOut()}) {
                        Text("SIGN OUT")
                            .foregroundColor(.red)
                }
            }

            Section(header: Text("SETTINGS")) {
                Text("Services")
                Text("Recipe")
                Text("Banking Account")
                Text("Security")
            }
            
            Section(header: Text("CONTACT")) {
                Text("About this version")
                Text("Terms of Use")
                Text("Privacy Policy")
                Text("Contact Us")
            }
        }.navigationBarTitle("Menu")
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}


