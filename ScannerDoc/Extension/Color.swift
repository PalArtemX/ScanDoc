//
//  Color.swift
//  ScannerDoc
//
//  Created by Artem Palyutin on 24.08.2021.
//

import Foundation
import SwiftUI



struct ColorTheme {
    let background = Color("Background")
    let text = Color("Text")
}

extension Color {
    static let colorTheme = ColorTheme()
}
