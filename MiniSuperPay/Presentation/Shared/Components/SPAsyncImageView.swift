//
//  SPAsyncImageView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 01/12/25.
//

import SwiftUI

struct SPAsyncImageView: View {
    // MARK: - Properties
    let imageURL: String
    let width: CGFloat?
    let height: CGFloat?
    let cornerRadius: CGFloat
    let contentMode: ContentMode
    
    // MARK: - Initialization
    init(
        imageURL: String,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        cornerRadius: CGFloat = DesignConstants.mediumRadius,
        contentMode: ContentMode = .fill
    ) {
        self.imageURL = imageURL
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.contentMode = contentMode
    }
    
    var body: some View {
        Group {
            if let url = URL(string: imageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        loadingView
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: contentMode)
                            .clipped()
                    case .failure:
                        errorView
                    @unknown default:
                        errorView
                    }
                }
            } else {
                errorView
            }
        }
        .frame(maxWidth: width == nil ? .infinity : width)
        .background(Color(.systemGray6))
        .cornerRadius(cornerRadius)
    }
    
    // MARK: - Loading View
    private var loadingView: some View {
        ZStack {
            Color(.systemGray6)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        }
    }
    
    // MARK: - Error View
    private var errorView: some View {
        ZStack {
            Color(.systemGray5)
            VStack(spacing: DesignConstants.smallSpacing) {
                Image(systemName: "photo")
                    .font(.system(size: 30))
                    .foregroundColor(.gray)
                SPTextView(
                    text: "Error",
                    size: DesignConstants.smFont,
                    textColor: .textColorLight
                )
            }
        }
    }
#warning("Implement image caching functions")
}

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        SPAsyncImageView(
            imageURL: "https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=800&q=80",
            width: 200,
            height: 200,
            contentMode: .fit
        )
        
        VStack {
            SPAsyncImageView(
                imageURL: "invalid-url",
                contentMode: .fit
            )
        }.frame(height: 200)
    }
    .padding()
}
