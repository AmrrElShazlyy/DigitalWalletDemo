//
//  TransactionRow.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//

import SwiftUI

struct TransactionRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let category: String
    let amount: Double
    let isExpense: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(icon)
                .resizedToFill(width: 50, height: 50)
                .padding(.leading, 10)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body.weight(.semibold))
                    .foregroundColor(.black)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.blue)
                    .shrinkToFit(0.8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .frame(width: 1, height: 40)
                .background(.greenBackground)
            
            Text(category)
                .font(.caption)
                .foregroundColor(.gray)
                .frame(width: 60, alignment: .center)
            
            Divider()
                .frame(width: 1, height: 40)
                .background(.greenBackground)
            
            Text((isExpense ? "-" : "") + amount.asCurrency())
                .font(.body.weight(.semibold))
                .foregroundColor(isExpense ? .blue : .black)
                .frame(width: 80, alignment: .trailing)
        }
        .frame(height: 60)
        .padding(.vertical, 4)
    }
}
