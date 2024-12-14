//
//  BudgetDetailView.swift
//  Budget
//
//  Created by Linas on 14/12/2024.
//

import SwiftUI

struct BudgetDetailView: View {
  
  @State private var expenseConfig = ExpenseConfig()
  @State private var isPresented: Bool = false
  
  var body: some View {
    VStack {
      
      /*
       Text("Budget Limit", format: .currency(code: Locale.currencyCode))
       .frame(maxWidth: .infinity, alignment: .leading)
       .padding()
       .font(.headline)
       */
      
      Form {
        Section("Budget") {
          //TextField("Budget name", text: $budget.name)
          //TextField("Budget limit", value: $budget.limit, format: .currency(code: Locale.currencyCode))
        }
        
        Section("Expenses") {
          Text("Display Budget Expenses")
        }
        
      }.navigationTitle("Budget Name")
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("Add Expense") {
          isPresented = true
        }
      }
    }
    .sheet(isPresented: $isPresented) {
      Text("AddExpense")
    }
  }
}

/*
struct ExpenseCellView: View {
    
    let expense: Expense
    
    var body: some View {
        HStack {
            Text("\(Text(expense.name)) (\(expense.quantity))")
            Spacer()
            Text(expense.total, format: .currency(code: Locale.currencyCode))
        }
    }
}
*/

#Preview {
  NavigationStack {
    BudgetDetailView()
  }
}
