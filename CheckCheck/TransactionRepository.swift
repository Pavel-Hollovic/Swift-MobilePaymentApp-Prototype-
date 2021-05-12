//
//  TransactionRepository.swift
//  CheckCheck
//
//  Created by Pavel Hollovic on 28.02.2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class TransactionRepository: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var transactions = [Transaction]()
    
    init() {
        loadData() //this intilize the loadfunction defined under
    }
    
    func loadData() {
        let userId = Auth.auth().currentUser?.uid //geting info about current user
        
        db.collection("transactions")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: userId) //load only data of sign in user
            .addSnapshotListener { (querySnapshot, Error) in
            if let querySnapshot = querySnapshot { //"if querysnapshot is not nill then.."
                self.transactions = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: Transaction.self)
                        return x
                    }
                    catch {
                        print(error)
                    }
                    return nil
                }
            }
        }
    }
    
    func addTransaction(_ transaction: Transaction) { //used in contentView. we call this in transactionlistViewModel
        do{
            var addedTransaction = transaction
            addedTransaction.userId = Auth.auth().currentUser?.uid //assigne user Id to transaction
            let _ = try db.collection("transactions").addDocument(from: addedTransaction)
        }
        catch {
            fatalError("Unable to encode transaction: \(error.localizedDescription)")
        }
    }
    
    func updateTransaction(_ transaction: Transaction){ //we call this in transactionCellViewModel
        if let transactionID = transaction.id {
            do {
                try db.collection("transactions").document(transactionID).setData(from: transaction)
            }
            catch {
                fatalError("Unable to encode transaction: \(error.localizedDescription)")
            }
        }
    }

}
