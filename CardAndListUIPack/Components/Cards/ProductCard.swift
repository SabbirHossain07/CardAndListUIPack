//
//  ProductCard.swift
//  CardAndListUIPack
//
//  Created by Sopnil Sohan on 17/12/25.
//

import SwiftUI

/// A beautiful product card component with image, price, and call-to-action button
public struct ProductCard: View {
    let imageName: String
    let title: String
    let description: String?
    let price: String
    let originalPrice: String?
    let ctaTitle: String
    let onCTATap: () -> Void
    
    @State private var isPressed = false
    
    public init(
        imageName: String,
        title: String,
        description: String? = nil,
        price: String,
        originalPrice: String? = nil,
        ctaTitle: String = "Add to Cart",
        onCTATap: @escaping () -> Void = {}
    ) {
        self.imageName = imageName
        self.title = title
        self.description = description
        self.price = price
        self.originalPrice = originalPrice
        self.ctaTitle = ctaTitle
        self.onCTATap = onCTATap
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Product Image
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
                    .frame(height: 200)
                
                Image(systemName: imageName)
                    .font(.system(size: 60))
                    .foregroundColor(.secondary)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.separator).opacity(0.2), lineWidth: 1)
            )
            
            // Product Info
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                if let description = description {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                // Price Section
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(price)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    if let originalPrice = originalPrice {
                        Text(originalPrice)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .strikethrough()
                    }
                }
                
                // CTA Button
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isPressed = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isPressed = false
                        onCTATap()
                    }
                }) {
                    HStack {
                        Spacer()
                        Text(ctaTitle)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.accentColor)
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .scaleEffect(isPressed ? 0.95 : 1.0)
            }
            .padding(16)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.separator).opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: - Preview
#Preview {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 16) {
            ProductCard(
                imageName: "iphone",
                title: "iPhone 15 Pro",
                description: "Latest flagship with A17 Pro chip",
                price: "$999",
                originalPrice: "$1,199",
                ctaTitle: "Add to Cart",
                onCTATap: {
                    print("Added to cart")
                }
            )
            .frame(width: 280)
            
            ProductCard(
                imageName: "airpodspro",
                title: "AirPods Pro",
                description: "Active Noise Cancellation",
                price: "$249",
                ctaTitle: "Buy Now",
                onCTATap: {
                    print("Buy now tapped")
                }
            )
            .frame(width: 280)
        }
        .padding()
    }
}

