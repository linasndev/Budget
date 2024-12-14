//
//  Expense.swift
//  Budget
//
//  Created by Linas on 14/12/2024.
//

import Foundation
import SwiftData

@Model
class Expense {
  var name: String = ""
  var price: Double = 0.0
  var quantity: Int = 1
  var budget: Budget? //Expense model belong to Budget model.
  
  init(name: String, price: Double, quantity: Int = 1, budget: Budget? = nil) {
    self.name = name
    self.price = price
    self.quantity = quantity
    self.budget = budget
  }
}

extension Expense {
  
  var total: Double {
    price * Double(quantity)
  }
}
