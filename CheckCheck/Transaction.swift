//
//  Transaction.swift
//  CheckCheck
//
//  Created by Pavel Hollovic on 28.02.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Transaction: Codable, Identifiable{
    @DocumentID var id: String? //documentID wrapper say put the id from firebase structure here (because it is defined in normal values
    var value: Float //Dont know if this is right type for UID
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp? //questionmark means this is optional field.. if this field is not filed server will fill it with its time! we dont want beckend to fill this. (that is why we use wrapper @ServerTimestamp
    var userId: String? //read optional string. Id to this field is assigned in repository 
}


#if DEBUG
let testDataTransactions = [
    Transaction(value: 152, completed: true),
    Transaction(value: 653, completed: true),
    Transaction(value: 452, completed: false)
]
#endif
