//
//  Budget.swift
//  Budget
//
//  Created by Linas on 14/12/2024.
//

import Foundation
import SwiftData

@Model
class Budget {
  
  var name: String = ""
  var limit: Double = 0.0
  @Relationship(deleteRule: .cascade, inverse: \Expense.budget) var expenses: [Expense]?
  
  init(name: String, limit: Double) {
    self.name = name
    self.limit = limit
  }
}


extension Budget {
  
  //This function are used to query and retrieve specific data from your SwiftData models.
  private func isUniqueName(context: ModelContext, name: String) throws -> Bool {
    //It defines a condition used to filter data when querying a data model.
    let predicate = #Predicate<Budget> { budget in
      budget.name.localizedStandardContains(name)
    }
    //It describes how to fetch data from the model
    let fetchDescriptor = FetchDescriptor(predicate: predicate)
    let results: [Budget] = try context.fetch(fetchDescriptor)
    return results.isEmpty
  }
  
  
  func save(context: ModelContext) throws {
    if try !isUniqueName(context: context, name: name) {
      throw BudgetError.duplicateName
    }
    context.insert(self)
    try context.save()
  }
  
  
}
