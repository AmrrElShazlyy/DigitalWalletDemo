//
//  Expenses.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 11/08/2025.
//

import Foundation

struct ExpensesData: Codable, Equatable {
    let totalExpenses: Double
    let totalBalance: Double
    let revenue: Double
    let foodCost: Double
    let salary: Double
    let groceries: Double
    let rent: Double
}

extension ExpensesData {
    static let placeholder = ExpensesData(
        totalExpenses: 0,
        totalBalance: 0,
        revenue: 0,
        foodCost: 0,
        salary: 0,
        groceries: 0,
        rent: 0
    )
}
