//
//  AddBudgetView.swift
//  Budget
//
//  Created by Linas on 14/12/2024.
//

import SwiftUI
import SwiftData

struct AddBudgetView: View {
  
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var modelContext
  
  @State private var name: String = ""
  @State private var limit: Double?
  @State private var errorMessage: String = ""
  
  private var isFormValid: Bool {
    guard let limit = limit else {
      return false
    }
    
    return !name.isEmptyOrWhitespace && limit > 0
  }
  
  var body: some View {
    NavigationStack {
      Form {
        Section("Budget info") {
          TextField("Name", text: $name)
            .accessibilityIdentifier("budgetNameTextField")
          
          TextField("Limit", value: $limit, format: .number)
            .accessibilityIdentifier("budgetLimitTextField")
          
          Text(errorMessage)
            .font(.caption2)
            .foregroundStyle(.red)
            .italic()
        }
      }
      .navigationTitle("Add Budget")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Save") {
            saveBudget()
          }
          .disabled(!isFormValid)
          .accessibilityIdentifier("saveBudgetButton")
        }
      }
    }
  }
  
  private func saveBudget() {
    guard let limit = limit else { return }
    
    do {
      let budget = Budget(name: name, limit: limit)
      try budget.save(context: modelContext)
      dismiss()
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}

#Preview {
  NavigationStack {
    AddBudgetView()
      .modelContainer(for: Budget.self, inMemory: true)
  }
}
