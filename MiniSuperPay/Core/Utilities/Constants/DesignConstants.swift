//
//  DesignConstants.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

// MARK: - Design constants for consistent UI
enum DesignConstants {
    enum Spacing {
        static let extraSmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }
    
    enum CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
    }
    
    enum IconSize {
        static let small: CGFloat = 16
        static let medium: CGFloat = 24
        static let large: CGFloat = 32
        static let extraLarge: CGFloat = 64
    }
    
    enum FontSize {
        static let caption: CGFloat = 12
        static let body: CGFloat = 14
        static let title: CGFloat = 18
    }
    
    enum Opacity {
        static let disabled: Double = 0.5
        static let overlay: Double = 0.3
        static let light: Double = 0.1
    }
}
