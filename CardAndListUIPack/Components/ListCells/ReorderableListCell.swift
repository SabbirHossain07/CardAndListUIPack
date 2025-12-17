//
//  ReorderableListCell.swift
//  CardAndListUIPack
//
//  Created by Sabbir Hossain on 17/12/25.
//

import SwiftUI

/// A reorderable list cell component
public struct ReorderableListCell: View {
    let icon: String
    let title: String
    let subtitle: String?
    let iconColor: Color
    
    public init(
        icon: String,
        title: String,
        subtitle: String? = nil,
        iconColor: Color = .blue
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.iconColor = iconColor
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(iconColor)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Image(systemName: "line.3.horizontal")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}

// MARK: - Reorderable List Container
/// A container view that makes a list reorderable
public struct ReorderableList<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    @Binding var items: [Data.Element]
    let content: (Data.Element) -> Content
    
    public init(
        items: Binding<[Data.Element]>,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self._items = items
        self.content = content
    }
    
    public var body: some View {
        List {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                content(item)
                    .tag(index)
            }
            .onMove { source, destination in
                items.move(fromOffsets: source, toOffset: destination)
            }
        }
        .environment(\.editMode, .constant(.active))
    }
}

// MARK: - Preview
struct ReorderableListPreview: View {
    struct Item: Identifiable {
        let id = UUID()
        let icon: String
        let title: String
        let subtitle: String?
        let color: Color
    }
    
    @State private var items = [
        Item(icon: "1.circle.fill", title: "First Item", subtitle: "Drag to reorder", color: .blue),
        Item(icon: "2.circle.fill", title: "Second Item", subtitle: "Drag to reorder", color: .green),
        Item(icon: "3.circle.fill", title: "Third Item", subtitle: "Drag to reorder", color: .orange),
        Item(icon: "4.circle.fill", title: "Fourth Item", subtitle: "Drag to reorder", color: .purple),
        Item(icon: "5.circle.fill", title: "Fifth Item", subtitle: "Drag to reorder", color: .red)
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    ReorderableListCell(
                        icon: item.icon,
                        title: item.title,
                        subtitle: item.subtitle,
                        iconColor: item.color
                    )
                }
                .onMove { source, destination in
                    items.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationTitle("Reorderable List")
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    ReorderableListPreview()
}

