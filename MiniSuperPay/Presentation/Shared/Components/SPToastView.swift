//
//  SPToastView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

// MARK: - Toast Type
enum SPToastType {
    case success
    case error
    case warning
    case info
    
    var icon: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .info: return "info.circle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .success: return .successColor
        case .error: return .errorColor
        case .warning: return .warningColor
        case .info: return .colorPrimary
        }
    }
}

// MARK: - SPToast View
struct SPToastView: View {
    let message: String
    let type: SPToastType
    
    init(message: String, type: SPToastType = .success) {
        self.message = message
        self.type = type
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: DesignConstants.smallSpacing) {
                Image(systemName: type.icon)
                    .font(.system(size: DesignConstants.lgFont))
                    .foregroundStyle(type.color)
                    .symbolEffect(.bounce, value: true)
                
                SPTextView(
                    text: message,
                    size: DesignConstants.baseFont,
                    weight: .semibold,
                    textColor: .textColor
                )
            }
            .padding(.horizontal, DesignConstants.largeSpacing)
            .padding(.vertical, DesignConstants.mediumSpacing)
            .background(
                Capsule()
                    .fill(.ultraThinMaterial)
                    .shadow(color: type.color.opacity(0.2), radius: 10, x: 0, y: 4)
            )
        }
        .padding(.bottom, 80)
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

#Preview("Success") {
    ZStack {
        Color.gray.opacity(0.3).ignoresSafeArea()
        SPToastView(message: "Added to cart!", type: .success)
    }
}

#Preview("Error") {
    ZStack {
        Color.gray.opacity(0.3).ignoresSafeArea()
        SPToastView(message: "Failed to add item", type: .error)
    }
}

#Preview("Warning") {
    ZStack {
        Color.gray.opacity(0.3).ignoresSafeArea()
        SPToastView(message: "Stock running low", type: .warning)
    }
}

#Preview("Info") {
    ZStack {
        Color.gray.opacity(0.3).ignoresSafeArea()
        SPToastView(message: "Product updated", type: .info)
    }
}
