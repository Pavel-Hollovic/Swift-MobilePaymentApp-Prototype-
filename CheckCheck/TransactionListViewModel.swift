//
//  TransactionListViewModel.swift
//  CheckCheck
//
//  Created by Pavel Hollovic on 28.02.2021.
//

import Foundation
import Combine

class TransactionListViewModel: ObservableObject {
    @Published var transactionRepository = TransactionRepository()
    @Published var transactionCellViewModels = [TransactionCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>() //Private object for data managment
    
    init() {
        transactionRepository.$transactions
            .map { transactions in
                transactions.map{transaction in
                    TransactionCellViewModel(transaction: transaction)
                }
            }
            .assign(to: \.transactionCellViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func addTransaction(transaction: Transaction){ //used in ContentView.
        transactionRepository.addTransaction(transaction)
        //let transactionVM = TransactionCellViewModel(transaction: transaction)
        //self.transactionCellViewModels.append(transactionVM)
    }
}
