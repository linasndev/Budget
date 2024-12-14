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
  
  init() {
    print(URL.applicationSupportDirectory.path(percentEncoded: false))
  }
  
  var body: some Scene {
    WindowGroup {
      BudgetListView()
        .modelContainer(for: Budget.self)
    }
  }
}
