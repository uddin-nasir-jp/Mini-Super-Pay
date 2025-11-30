//
//  Color+Theme.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

extension Color {
    // MARK: - Brand Colors
    
    /// Primary color - Blue
    static let colorPrimary = Color("ThemePrimary")
    
    /// Secondary color - Gray
    static let colorSecondary = Color("ThemeSecondary")
    
    static let bgColor = Color("BGColor")
    
    // MARK: - Text Colors
    /// Primary text color
    static let textColor = Color("TextColor")
    
    /// Secondary text color - Descriptions and labels
    static let textColorLight = Color("TextColorLight")
    
    // MARK: - Status Colors
    static let successColor = Color("SuccessColor")
    static let errorColor = Color("ErrorColor")
    static let warningColor = Color("WarningColor")
    
    // MARK: - Interactive States
    
    /// Disabled state color for buttons and controls
    static let disabledColor: Color = colorSecondary.opacity(0.8)
    
    /// Disabled background color for buttons
    static let disabledBackgroundColor: Color = colorPrimary.opacity(0.8)
    
    /// Disabled text color
    static let disabledTextColor: Color = textColorLight.opacity(0.8)
}
