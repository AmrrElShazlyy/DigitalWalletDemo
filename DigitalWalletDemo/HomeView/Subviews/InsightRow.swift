//
//  InsightRow.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//

import SwiftUI

struct InsightRow: View {
    let icon: String
    let title: String
    let value: String
    var valueColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .padding(8)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .shrinkToFit(0.8)
                Text(value)
                    .font(.subheadline.bold())
                    .foregroundColor(valueColor)
            }
        }
    }
}
