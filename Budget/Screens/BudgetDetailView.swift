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
  
  //Filter expenses base on Budget
  @Query private var expenses: [Expense] = []
  
  init(budget: Budget) {
    self.budget = budget
    
    let budgetID = self.budget.persistentModelID
    
    let predicate = #Predicate<Expense> {
      if let budget = $0.budget {
        return budget.persistentModelID == budgetID
      } else {
        return false
      }
    }
    
    _expenses = Query(filter: predicate)
  }
  
  @Bindable var budget: Budget
  
  var body: some View {
    Form {
      Section("Info Budget") {
        VStack(alignment: .leading) {
          HStack(spacing: 1) {
            Text("Budget Limit: ")
            Text(budget.limit, format: .currency(code: Locale.currencyCode))
              .fontWeight(.bold)
          }
          .font(.footnote)
          
          HStack(spacing: 1) {
            Text("Budget Spent: ")
            Text(budget.spentExpenses, format: .currency(code: Locale.currencyCode))
              .fontWeight(.bold)
              .foregroundStyle(insufficientFundsColor)
          }
          .font(.footnote)
          
          HStack(spacing: 1) {
            Text("Budget Remain: ")
            Text(budget.remainBudget, format: .currency(code: Locale.currencyCode))
              .fontWeight(.bold)
              .foregroundStyle(insufficientFundsColor)
          }
          .font(.footnote)
        }
      }
      
      Section("Budget") {
        TextField("New Budget name", text: $budget.name)
        TextField("New Budget limit", value: $budget.limit, format: .currency(code: Locale.currencyCode))
        Button("Add Expenses") {
          isPresentedAddExpenses.toggle()
        }
        .disabled(budget.remainBudget < 0)
        
      }
      
      Section("Expenses") {
          List {
            ForEach(expenses) { expense in
              ExpenseCellView(expense: expense)
            }
            .onDelete(perform: deleteExpense)
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
  
  private var insufficientFundsColor: Color {
    budget.remainBudget < 0 ? .red : .primary
  }
  
  private func deleteExpense(offsets: IndexSet) {
    guard let expenses = budget.expenses else { return } // Exit if expenses is nil
    
    for index in offsets.sorted(by: >) {
      let expenseToDelete = expenses[index]
      budget.expenses?.remove(at: index)
      modelContext.delete(expenseToDelete)
    }
    
    do {
      try modelContext.save()
    } catch {
      print("❌ NOT DELETE")
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

//MARK: - Preview 1 -
#Preview("Preview", traits: .modifier(BudgetModelPreviewModifier())) {
  @Previewable @Query var budgets: [Budget]
  
  NavigationStack {
    BudgetDetailView(budget: budgets[0])
  }
}


//MARK: - Preview 1 -
struct BudgetDetailViewContainer: View {
  
  @Query(sort: \Budget.name, order: .forward) private var budgets: [Budget]
  
  var body: some View {
    BudgetDetailView(budget: budgets[0])
  }
}

#Preview("Second Preview") {
  NavigationStack {
    BudgetDetailViewContainer()
      .modelContainer(previewContainer)
  }
}

