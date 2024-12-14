//
//  String+Ext.swift
//  Budget
//
//  Created by Linas on 14/12/2024.
//

import Foundation

extension String {
  
  var isEmptyOrWhitespace: Bool {
    trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
}
