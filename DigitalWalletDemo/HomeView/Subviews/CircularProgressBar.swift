//
//  CircularProgressBar.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//

import SwiftUI

struct CircularProgressBar: View {
    let value: Double
    var body: some View {
        ZStack {
            Circle().stroke(Color.white, lineWidth: 5)
            Circle()
                .trim(from: 0, to: min(max(value, 0), 1))
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: 5)
                )
                .rotationEffect(.degrees(-90))
            Image("Car")
        }
    }
}
