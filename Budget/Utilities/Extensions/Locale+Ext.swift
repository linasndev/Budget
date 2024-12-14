//
//  Locale+Ext.swift
//  Budget
//
//  Created by Linas on 14/12/2024.
//

import Foundation

extension Locale {
  
  static var currencyCode: String {
    Locale.current.currency?.identifier ?? "USD"
  }
}
