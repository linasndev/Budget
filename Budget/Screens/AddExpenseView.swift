//
//  AddExpenseView.swift
//  Budget
//
//  Created by Linas on 14/12/2024.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
  
  @Environment(\.dismiss) private var dismiss
  @State private var expenseConfig = ExpenseConfig()
  
  var body: some View {
    Form {
      Section("Add Expense") {
        /*
         TextField("Expense name", text: $expenseConfig.name)
         TextField("Expense price", value: $expenseConfig.price, format: .number)
         TextField("Expense quantity", value: $expenseConfig.quantity, format: .number)
         */
        Button(action: {
          // save expenses
          if expenseConfig.isValid {
            // save expenses
            
          }
        }, label: {
          Text("Save Expense")
            .frame(maxWidth: .infinity)
        })
        .buttonStyle(.borderedProminent)
        .listRowSeparator(.hidden)
        
      }
    }
    .navigationTitle("Add Expense")
  }
}

struct ExpenseConfig {
  
  var name: String = ""
  var price: Double?
  var quantity: Int = 1
  
  var isValid: Bool {
    guard let price = price else { return false }
    return !name.isEmptyOrWhitespace && price > 0 && quantity > 0
  }
}

#Preview {
  NavigationStack {
    AddExpenseView()
  }
}
