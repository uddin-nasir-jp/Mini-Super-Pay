//
//  CustomTextView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

struct SPTextView: View {
    var text: String
    var size: CGFloat = DesignConstants.smFont
    var weight: Font.Weight = .regular
    var textColor: Color = .white
    var alignment: TextAlignment = .leading
    
    var body: some View {
        Text(text)
            .font(.system(size: size, weight: (weight), design: .monospaced))
            .foregroundColor(textColor)
            .multilineTextAlignment(alignment)
    }
}
