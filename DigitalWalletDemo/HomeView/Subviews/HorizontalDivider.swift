//
//  HorizontalDivider.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//

import SwiftUI

struct HorizontalDivider: View {
    var color: Color = Color(.separator)
    var thickness: CGFloat = 1
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: thickness)
            .frame(maxWidth: .infinity)
    }
}
