//
//  ContentView.swift
//  CheckCheck
//
//  Created by Pavel Hollovic on 14.02.2021.
//

import SwiftUI
import Firebase

struct MainScreenView: View {
    @State private var transactionCreated:Bool = false
    @State var ammount: String = ""
    @State var showSignInForm = false
    @State var name = Auth.auth().currentUser?.displayName
    
    var body: some View {
        VStack {
            NavigationView{
                
                VStack {
                    if self.transactionCreated {

                        Text("Scan!").padding()
                        QRCodeView(url: "https://checkcheck-1043b.web.app?id=" + ammount)
                    }
                    else {
                        CheckCheckButton(transactionCreated: $transactionCreated, ammount: $ammount)
                    }
                    //Button(action: {self.showSignInForm.toggle()}){
                        //Image(systemName: "person.circle")}
                    TextField("How Much?", text: $ammount).keyboardType(.decimalPad)
                        .padding()
                        .disabled(self.transactionCreated)
                        .foregroundColor(self.transactionCreated ? .gray : Color.primary)
                    
                    
                }
                .sheet(isPresented: $showSignInForm){
                    SignInView()
                }
                
                .navigationTitle(Text("CheckCheck"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                            if self.transactionCreated{
                                ResetButton(transactionCreted: $transactionCreated)
                                }
                            }
                    ToolbarItem(placement: .confirmationAction) {
                        NavigationLink(destination: MenuView()) {
                            Text("Menu")
                            Image(systemName: "person")
                        }
                    }
                }
                
            }
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}

struct CheckCheckButton: View {
    @ObservedObject var transactionListVM = TransactionListViewModel()
    @Binding var transactionCreated: Bool
    @Binding var ammount: String
    //@ObservedObject var transactionCellVM: TransactionCellViewModel
    var body: some View {
        Button(action: {
            self.transactionCreated.toggle();
            self.transactionListVM.addTransaction(transaction: Transaction(value: Float(self.ammount) ?? 0.0, completed: false))
        }) {
            HStack {
                Image(systemName: "checkmark")
                    .font(.title)
                Text("CheckCheck")
                    .fontWeight(.semibold)
                    .font(.title)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(40)
        }
    }
}

struct ResetButton: View {
    @Binding var transactionCreted: Bool
    var body: some View {
        Button(action: {
            self.transactionCreted.toggle()
        }) {
            Text("Reset")
        }
    }
}

