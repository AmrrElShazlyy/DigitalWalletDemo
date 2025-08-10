//
//  ContianerView.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 10/08/2025.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 70)
                .foregroundColor(Color.whiteBackground)
//            VStack {
//                Spacer()
//                Rectangle()
//                    .frame(height: 25)
//                    .foregroundColor(Color.lightBackground)
//            }
            content
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ContainerView() {
        VStack {
            Text("Hello")
        }
    }
    .background(Color.greenBackground)
}
