//
//  PreviewContainer.swift
//  Budget
//
//  Created by Linas on 14/12/2024.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
var previewContainer: ModelContainer = {
  let container = try! ModelContainer(for: Budget.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
  
  SampleBudgetData.budgets.forEach { budget in
    container.mainContext.insert(budget)
    try! container.mainContext.save()
  }

  return container
}()

//iOS 18 Previewable
struct BudgetModelPreviewModifier: PreviewModifier {
  func body(content: Content, context: ModelContainer) -> some View {
    content
      .modelContainer(context)
  }
  
  static func makeSharedContext() async throws -> ModelContainer {
    return previewContainer
  }
}

struct SampleBudgetData {
  static var budgets: [Budget] {
    return [
      Budget(name: "Groceries", limit: 400),
      Budget(name: "Vocation", limit: 2000),
      Budget(name: "Party", limit: 200)
    ]
  }
  
  static var expenses: [Expense] {
    [
      Expense(name: "Bread", price: 4.60, quantity: 1)
      
    ]
  }
}
