//
//  ProductImageView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

struct ProductImageView: View {
    let imageName: String?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DesignConstants.mediumRadius)
                .fill(Color(.systemGray6))
                .frame(height: 280)
            
            Image(systemName: imageName ?? "photo")
                .font(.system(size: 100))
                .foregroundStyle(Color.textColorLight)
        }
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    ProductImageView(imageName: "cart")
        .padding()
}
