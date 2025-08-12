//
//  BottomTabBar.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//
import SwiftUI

struct BottomTabBar: View {
    @Binding var selection: AppTab
    
    var body: some View {
        HStack(spacing: 14) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                TabButton(
                    tabIcon: tab.symbol,
                    isSelected: selection == tab
                ) {
                    selection = tab
                }
                .padding(.bottom)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 14)
        .padding(.bottom, 40)
        .background(
            RoundedRectangle(cornerRadius: 36)
                .fill(Color.lightGreen)
        )
    }
}

private struct TabButton: View {
    let tabIcon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(tabIcon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(isSelected ? Color.greenBackground : .clear)
                )
        }
    }
}
