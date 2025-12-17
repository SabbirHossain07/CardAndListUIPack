//
//  SwipeableListCell.swift
//  CardAndListUIPack
//
//  Created by Sabbir Hossain on 17/12/25.
//

import SwiftUI

/// A list cell with swipe actions for iOS 15+
public struct SwipeableListCell<Content: View>: View {
    let content: Content
    let leadingActions: [SwipeAction]
    let trailingActions: [SwipeAction]
    
    public struct SwipeAction {
        let title: String
        let icon: String?
        let color: Color
        let action: () -> Void
        
        public init(
            title: String,
            icon: String? = nil,
            color: Color = .blue,
            action: @escaping () -> Void
        ) {
            self.title = title
            self.icon = icon
            self.color = color
            self.action = action
        }
    }
    
    /// Initialize a swipeable list cell
    /// - Parameters:
    ///   - leadingActions: Actions shown when swiping from left
    ///   - trailingActions: Actions shown when swiping from right
    ///   - content: The cell content
    public init(
        leadingActions: [SwipeAction] = [],
        trailingActions: [SwipeAction] = [],
        @ViewBuilder content: () -> Content
    ) {
        self.leadingActions = leadingActions
        self.trailingActions = trailingActions
        self.content = content()
    }
    
    public var body: some View {
        content
            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                ForEach(Array(leadingActions.enumerated()), id: \.offset) { _, action in
                    Button(action: action.action) {
                        if let icon = action.icon {
                            Label(action.title, systemImage: icon)
                        } else {
                            Text(action.title)
                        }
                    }
                    .tint(action.color)
                }
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                ForEach(Array(trailingActions.enumerated()), id: \.offset) { _, action in
                    Button(action: action.action) {
                        if let icon = action.icon {
                            Label(action.title, systemImage: icon)
                        } else {
                            Text(action.title)
                        }
                    }
                    .tint(action.color)
                }
            }
    }
}

// MARK: - Preview
#Preview {
    List {
        SwipeableListCell(
            leadingActions: [
                SwipeableListCell.SwipeAction(title: "Pin", icon: "pin.fill", color: Color.yellow) {
                    print("Pinned")
                }
            ],
            trailingActions: [
                SwipeableListCell.SwipeAction(title: "Delete", icon: "trash.fill", color: Color.red) {
                    print("Deleted")
                },
                SwipeableListCell.SwipeAction(title: "Archive", icon: "archivebox.fill", color: Color.blue) {
                    print("Archived")
                }
            ]
        ) {
            HStack {
                Image(systemName: "envelope.fill")
                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Text("Important Email")
                        .font(.headline)
                    Text("Swipe left or right for actions")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.vertical, 8)
        }
        
        SwipeableListCell(
            trailingActions: [
                SwipeableListCell.SwipeAction(title: "Delete", icon: "trash", color: Color.red) {
                    print("Deleted")
                }
            ]
        ) {
            HStack {
                Image(systemName: "message.fill")
                    .foregroundColor(.green)
                Text("Another message")
                    .font(.headline)
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
    .listStyle(.plain)
}

