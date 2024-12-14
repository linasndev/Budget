//
//  BudgetError.swift
//  Budget
//
//  Created by Linas on 14/12/2024.
//

import Foundation

enum BudgetError: LocalizedError {
  case duplicateName
  
  var errorDescription: String? {
    switch self {
      case .duplicateName:
        return "The budget name must be unique."
    }
  }
}
