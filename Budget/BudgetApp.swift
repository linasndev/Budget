//
//  BudgetApp.swift
//  Budget
//
//  Created by Linas on 14/12/2024.
//

import SwiftUI
import SwiftData

@main
struct BudgetApp: App {
  var body: some Scene {
    WindowGroup {
      BudgetListView()
        .modelContainer(for: Budget.self)
    }
  }
}
