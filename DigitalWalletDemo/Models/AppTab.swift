//
//  AppTab.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//
import Foundation

enum AppTab: CaseIterable, Hashable {
    case home, analysis, transactions, category, profile

    var title: String {
        switch self {
        case .home: return "Home"
        case .analysis: return "Analysis"
        case .transactions: return "Transactions"
        case .category: return "Category"
        case .profile: return "Profile"
        }
    }

    var symbol: String {
        switch self {
        case .home: return "Home"
        case .analysis: return "Analysis"
        case .transactions: return "Transactions"
        case .category: return "Category"
        case .profile: return "Profile"
        }
    }
}
