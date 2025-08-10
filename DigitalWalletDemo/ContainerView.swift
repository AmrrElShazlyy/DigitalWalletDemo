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
            RoundedRectangle(cornerRadius: 50)
                .foregroundColor(Color.whiteBackground)
                .edgesIgnoringSafeArea(.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            content
        }
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
