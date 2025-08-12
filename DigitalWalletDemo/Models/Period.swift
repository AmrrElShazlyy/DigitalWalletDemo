//
//  Period.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//

enum Period: CaseIterable {
    case daily, weekly, monthly

    var title: String {
        switch self {
        case .daily: 
            return "Daily"
        case .weekly: 
            return "Weekly"
        case .monthly: 
            return "Monthly"
        }
    }
}
