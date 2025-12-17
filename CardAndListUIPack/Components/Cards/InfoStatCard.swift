//
//  InfoStatCard.swift
//  CardAndListUIPack
//
//  Created by Sopnil Sohan on 17/12/25.
//

import SwiftUI

/// A beautiful info/stat card component for displaying key metrics and statistics
public struct InfoStatCard: View {
    let title: String
    let value: String
    let subtitle: String?
    let icon: String?
    let iconColor: Color
    let gradient: LinearGradient?
    
    public init(
        title: String,
        value: String,
        subtitle: String? = nil,
        icon: String? = nil,
        iconColor: Color = .blue,
        gradient: LinearGradient? = nil
    ) {
        self.title = title
        self.value = value
        self.subtitle = subtitle
        self.icon = icon
        self.iconColor = iconColor
        self.gradient = gradient
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(iconColor)
                }
                Spacer()
            }
            
            Text(value)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(gradient != nil ? AnyShapeStyle(gradient!) : AnyShapeStyle(Color(.systemBackground)))
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
    VStack(spacing: 16) {
        HStack(spacing: 16) {
            InfoStatCard(
                title: "Total Users",
                value: "12.5K",
                subtitle: "+12% from last month",
                icon: "person.3.fill",
                iconColor: .blue
            )
            
            InfoStatCard(
                title: "Revenue",
                value: "$45.2K",
                subtitle: "+8% from last month",
                icon: "dollarsign.circle.fill",
                iconColor: .green,
                gradient: LinearGradient(
                    colors: [Color.green.opacity(0.3), Color.green.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
        
        InfoStatCard(
            title: "Active Sessions",
            value: "1,234",
            subtitle: "Currently online",
            icon: "chart.line.uptrend.xyaxis",
            iconColor: .purple
        )
    }
    .padding()
}

