//
//  BudgetDetailView.swift
//  Budget
//
//  Created by Linas on 14/12/2024.
//

import SwiftUI
import SwiftData

struct BudgetDetailView: View {
  
  @Environment(\.modelContext) private var modelContext
  
  @State private var expenseConfig = ExpenseConfig()
  @State private var isPresentedAddExpenses: Bool = false
  
  @Bindable var budget: Budget
  
  var body: some View {
    VStack {
      HStack {
        Text("Limit Budget: ")
        Text(budget.limit, format: .currency(code: Locale.currencyCode))
      }
      
      Form {
        Section("Budget") {
          
          TextField("New Budget name", text: $budget.name)
          TextField("New Budget limit", value: $budget.limit, format: .currency(code: Locale.currencyCode))
          
          
          Button("Add Expenses") {
            isPresentedAddExpenses.toggle()
          }
        }
        
        Section("Expenses") {
          if let expenses = budget.expenses {
            List {
              ForEach(expenses) { expense in
                ExpenseCellView(expense: expense)
              }
            }
          }
        }
        .navigationTitle(budget.name)
        .navigationBarTitleDisplayMode(.inline)
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Update") {
            do {
              try modelContext.save()
            } catch {
              print(error.localizedDescription)
            }
          }
        }
      }
      .sheet(isPresented: $isPresentedAddExpenses) {
        AddExpenseView(budget: budget)
      }
    }
  }
}
  
  
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


#Preview("Preview", traits: .modifier(BudgetModelPreviewModifier())) {
  @Previewable @Query var budgets: [Budget]
  
  NavigationStack {
    BudgetDetailView(budget: budgets[0])
  }
}

