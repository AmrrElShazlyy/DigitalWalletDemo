//
//  SegmentedTabs.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//

import SwiftUI

struct SegmentedTabs: View {
    @Binding var selection: Period
    let tabs: [String]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(Array(tabs.enumerated()), id: \.offset) { id, title in
                let period = Period.allCases[id]
                Button {
                    selection = period
                } label: {
                    Text(title)
                        .font(.subheadline)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .background(selection == period ? Color.greenBackground : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .circular))
                }
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.lightGreen)
        )
    }
}
