//
//  ImageExtension.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//

import SwiftUI

extension Image {
  func resizedToFill(width: CGFloat, height: CGFloat) -> some View {
    self
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: width, height: height)
  }
}
