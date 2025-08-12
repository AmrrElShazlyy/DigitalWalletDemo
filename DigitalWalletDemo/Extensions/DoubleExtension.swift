//
//  DoubleExtension.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//

import Foundation

extension Double {
    func asCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 1
        return formatter.string(from: self as NSNumber) ?? "\(self)"
    }
}
