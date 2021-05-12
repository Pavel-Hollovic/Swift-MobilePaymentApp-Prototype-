//
//  TransactionListView.swift
//  CheckCheck
//
//  Created by Pavel Hollovic on 28.02.2021.
//

import Foundation
import SwiftUI

struct TransactionListView: View {
    @ObservedObject var transactionListVM = TransactionListViewModel()
    
    //let transactions = testDataTransactions
    
    var body: some View{
        NavigationView {
            List(transactionListVM.transactionCellViewModels) { transactionCellVM in
                    TransactionCell(transactionCellVM: transactionCellVM)
                }
        }.navigationBarTitle("Transactions History")
        
    }
}

struct TransationListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}


struct TransactionCell: View {
    @ObservedObject var transactionCellVM: TransactionCellViewModel

    var body: some View {
        HStack{
            Image(systemName: transactionCellVM.transaction.completed ? "checkmark.circle.fill" : "xmark.circle")
                .resizable()
                .frame(width: 20, height: 20)
            Text(String(transactionCellVM.transaction.value)+" CZK")
        }
    }
}
