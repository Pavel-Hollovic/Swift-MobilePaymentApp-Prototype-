//
//  TransactionCellViewModel.swift
//  CheckCheck
//
//  Created by Pavel Hollovic on 28.02.2021.
//

import Foundation
import Combine

class TransactionCellViewModel: ObservableObject, Identifiable {
    @Published var transactionRepository = TransactionRepository()
    @Published var transaction: Transaction
    
    var id = ""
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(transaction: Transaction){
        self.transaction = transaction
        
        $transaction
            .map { transaction in //transaction coming in
                transaction.completed ? "checkmark.circle.fill":"xmark.circle" //return : this convert copleted status to specific string
            }
            .assign(to: \.completionStateIconName, on: self) //this store the string to copletationStateIconName
            .store(in: &cancellables) //this is here for memory managment pourpose. Read: "store result in cancellables"
        
        $transaction
            .compactMap { transaction in
                transaction.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $transaction //this calling update function. Ideal place two piplines above are checking for updates
            .dropFirst() //this is here to prevent endless loop. we are droping the first update from us
            //.debounce(for: 0.8, scheduler: RunLoop.main) use this if its manal input from user. Elswhere it will send update with pressing every key on keyboard..
            .sink { transaction in
                self.transactionRepository.updateTransaction(transaction)
            }
            .store(in: &cancellables)
    }
    
}
