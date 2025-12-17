//
//  ProfileListCell.swift
//  CardAndListUIPack
//
//  Created by Sabbir Hossain on 17/12/25.
//

import SwiftUI

/// A beautiful profile list cell component for displaying user profiles in lists
public struct ProfileListCell: View {
    let imageName: String
    let name: String
    let subtitle: String?
    let detail: String?
    let isOnline: Bool
    let accessoryType: AccessoryType
    
    public enum AccessoryType {
        case none
        case disclosure
        case badge(String)
        case custom(AnyView)
    }
    
    /// Initialize a profile list cell
    /// - Parameters:
    ///   - imageName: Name of the profile image or SF Symbol
    ///   - name: User's name
    ///   - subtitle: Optional subtitle (e.g., username, role)
    ///   - detail: Optional detail text (e.g., last seen, status)
    ///   - isOnline: Whether the user is online
    ///   - accessoryType: Type of accessory to show on the right
    public init(
        imageName: String,
        name: String,
        subtitle: String? = nil,
        detail: String? = nil,
        isOnline: Bool = false,
        accessoryType: AccessoryType = .disclosure
    ) {
        self.imageName = imageName
        self.name = name
        self.subtitle = subtitle
        self.detail = detail
        self.isOnline = isOnline
        self.accessoryType = accessoryType
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            // Profile Image
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 50, height: 50)
                
                Image(systemName: imageName)
                    .font(.title2)
                    .foregroundColor(.white)
                
                // Online indicator
                if isOnline {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 14, height: 14)
                        .overlay(
                            Circle()
                                .stroke(Color(.systemBackground), lineWidth: 2)
                        )
                }
            }
            
            // Text Content
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let detail = detail {
                    Text(detail)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Accessory
            accessoryView
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .contentShape(Rectangle())
    }
    
    @ViewBuilder
    private var accessoryView: some View {
        switch accessoryType {
        case .none:
            EmptyView()
        case .disclosure:
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        case .badge(let text):
            Text(text)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(Color.accentColor)
                )
        case .custom(let view):
            view
        }
    }
}

// MARK: - Preview
#Preview {
    List {
        ProfileListCell(
            imageName: "person.circle.fill",
            name: "John Doe",
            subtitle: "@johndoe",
            detail: "Active 2 hours ago",
            isOnline: true,
            accessoryType: .badge("3")
        )
        
        ProfileListCell(
            imageName: "person.circle.fill",
            name: "Jane Smith",
            subtitle: "Product Designer",
            detail: "Last seen yesterday",
            isOnline: false,
            accessoryType: .disclosure
        )
        
        ProfileListCell(
            imageName: "person.circle.fill",
            name: "Mike Johnson",
            subtitle: "@mikej",
            isOnline: true,
            accessoryType: .none
        )
    }
    .listStyle(.plain)
}

