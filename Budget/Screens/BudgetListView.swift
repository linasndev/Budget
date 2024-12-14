//
//  BudgetListView.swift
//  Budget
//
//  Created by Linas on 14/12/2024.
//

import SwiftUI
import SwiftData

struct BudgetListView: View {
  
  @State private var isPresentedAddBudgetSheet: Bool = false
  @Query private var budgets: [Budget]
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(budgets) { budget in
          NavigationLink(value: budget) {
            BudgetCellView(budget: budget)
          }
        }
      }
      .accessibilityIdentifier("budgetCollentionView")
      .listStyle(.plain)
      .navigationTitle("Budgets")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Add Budget") {
            isPresentedAddBudgetSheet.toggle()
          }
          .accessibilityIdentifier("addBudgetButton")
        }
      }
      .sheet(isPresented: $isPresentedAddBudgetSheet) {
        AddBudgetView()
      }
      .navigationDestination(for: Budget.self) { budget in
        BudgetDetailView(budget: budget)
      }
    }
  }
}

#Preview {
  NavigationStack {
    BudgetListView()
      .modelContainer(previewContainer)
  }
}


fileprivate struct BudgetCellView: View {
  
  let budget: Budget
  
  var body: some View {
    HStack {
      Text(budget.name)
      Spacer()
      Text(budget.limit, format: .currency(code: Locale.currencyCode))
    }
  }
}
