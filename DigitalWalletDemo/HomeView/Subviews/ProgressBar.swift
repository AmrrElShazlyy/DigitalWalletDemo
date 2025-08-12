//
//  ProgressBar.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//
import SwiftUI

struct ProgressBar: View {
    let value: Double
    let total: Double
    
    private var progress: CGFloat {
        guard total > 0 else { return 0 }
        let p = value / total
        return CGFloat(min(max(p, 0), 1))
    }
    
    var body: some View {
        // note: we can use here scaleEffect modifier on Capsule instead of using GeometryReader
        // i know that GeometryReader isn;t the best option as it makes heavy computation
        GeometryReader { geometry in
            let fillWidth = geometry.size.width * progress
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white)
                Capsule()
                    .fill(Color.black)
                    .frame(width: fillWidth, alignment: .leading)
                Text("\(Int(progress * 100))%")
                    .font(.caption.bold())
                    .foregroundColor(fillWidth > 20 ? Color.white : Color .black)
                    .padding(.horizontal, 15)
            }
        }
        .frame(height: 30)
    }
}
