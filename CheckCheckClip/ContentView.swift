//
//  ContentView.swift
//  CheckCheckClip
//
//  Created by Pavel Hollovic on 05.04.2021.
//

import SwiftUI
import PassKit
import UIKit


struct ContentView: View {
    
    @State var deeplinkUserId = ""
    
    
    struct ApplePayButton: UIViewRepresentable {
            func updateUIView(_ uiView: PKPaymentButton, context: Context) {
        
            }
            func makeUIView(context: Context) -> PKPaymentButton {
                    return PKPaymentButton(paymentButtonType: .plain, paymentButtonStyle: .black)
            }
    }
    struct ApplePayButtonStyle: ButtonStyle {
            func makeBody(configuration: Self.Configuration) -> some View {
                 return ApplePayButton()
            }
    }
    
    var body: some View {
        
        VStack {
            Text("You will have to pay ammount of: " + deeplinkUserId + " CZK")
                .padding()
                .onContinueUserActivity( NSUserActivityTypeBrowsingWeb,
                                        perform: handleUserActivity
            )

            Button( action: {}, label: { Text("")} )
            .frame(width: 212, height: 38, alignment: .center)
            .buttonStyle(ApplePayButtonStyle())
        }
        
    }
    
    
    
    
    
    
    private func handleUserActivity(_ userActivity: //this handles deep link parcing
                                        NSUserActivity) {
        guard
            let incomingURL = userActivity.webpageURL,
            let urlComponents = URLComponents(url:
                incomingURL, resolvingAgainstBaseURL: true),
            let queryItems = urlComponents.queryItems,
            let id = queryItems.first(where: { $0.name == "id" })?.value
                else {
                 deeplinkUserId = "No Transaction to process"
                return
                }
        
            deeplinkUserId = String(id)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
