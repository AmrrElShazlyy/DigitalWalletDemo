//
//  BalanceView.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//

import SwiftUI

struct BalanceView: View {
    let title: String
    let imageName: String
    let value: String
    var valueColor: Color = .white
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(imageName)
                Text(title)
                    .font(.caption)
            }
            Text(value)
                .font(.title3.bold())
                .foregroundColor(valueColor)
        }
        .frame(maxWidth: .infinity)
    }
}
