//
//  ShrinkToFit.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//

import SwiftUI

struct ShrinkToFit: ViewModifier {
    var minScale: CGFloat = 0.6
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .allowsTightening(true)
            .fixedSize(horizontal: false, vertical: true)
    }
}
extension View {
    func shrinkToFit(_ minScale: CGFloat = 0.6) -> some View { modifier(ShrinkToFit(minScale: minScale)) }
}
