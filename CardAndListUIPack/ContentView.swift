//
//  ContentView.swift
//  CardAndListUIPack
//
//  Created by Sopnil Sohan on 17/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CardsView()
                .tabItem {
                    Label("Cards", systemImage: "rectangle.stack")
                }
                .tag(0)
            
            ListCellsView()
                .tabItem {
                    Label("List Cells", systemImage: "list.bullet")
                }
                .tag(1)
            
            AllComponentsView()
                .tabItem {
                    Label("All", systemImage: "square.grid.2x2")
                }
                .tag(2)
        }
    }
}

// MARK: - Cards View
struct CardsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Info/Stat Cards Section
                    SectionHeader(
                        title: "Info/Stat Cards",
                        subtitle: "Display key metrics and statistics"
                    )
                    
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
                    
                    // Product Cards Section
                    SectionHeader(
                        title: "Product Cards",
                        subtitle: "With price and call-to-action",
                        actionTitle: "See All"
                    ) {
                        print("See all products")
                    }
                    
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
                                    print("Added iPhone to cart")
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
                                    print("Buy AirPods Pro")
                                }
                            )
                            .frame(width: 280)
                            
                            ProductCard(
                                imageName: "applewatch",
                                title: "Apple Watch",
                                description: "Series 9 with advanced health features",
                                price: "$399",
                                ctaTitle: "Add to Cart",
                                onCTATap: {
                                    print("Added Apple Watch to cart")
                                }
                            )
                            .frame(width: 280)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Card Components")
        }
    }
}

// MARK: - List Cells View
struct ListCellsView: View {
    @State private var items = [
        "First Item",
        "Second Item",
        "Third Item",
        "Fourth Item",
        "Fifth Item"
    ]
    
    var body: some View {
        NavigationView {
            List {
                // Profile List Cells Section
                Section {
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
                } header: {
                    ListSectionHeader(
                        title: "Profile List Cells",
                        subtitle: "User profiles with online status"
                    )
                }
                
                // Async Image Cells Section
                Section {
                    AsyncImageCellModern(
                        imageURL: URL(string: "https://picsum.photos/200/200?random=1"),
                        title: "Beautiful Landscape",
                        subtitle: "Nature photography at its finest"
                    )
                    
                    AsyncImageCellModern(
                        imageURL: URL(string: "https://picsum.photos/200/200?random=2"),
                        title: "City Skyline",
                        subtitle: "Urban architecture showcase"
                    )
                    
                    AsyncImageCellModern(
                        imageURL: nil,
                        title: "No Image Available",
                        subtitle: "Placeholder example"
                    )
                } header: {
                    ListSectionHeader(
                        title: "Async Image Cells",
                        subtitle: "With placeholder support"
                    )
                }
                
                // Swipeable Cells Section
                Section {
                    SwipeableListCell(
                        leadingActions: [
                            SwipeableListCell.SwipeAction(
                                title: "Pin",
                                icon: "pin.fill",
                                color: Color.yellow
                            ) {
                                print("Pinned")
                            }
                        ],
                        trailingActions: [
                            SwipeableListCell.SwipeAction(
                                title: "Delete",
                                icon: "trash.fill",
                                color: Color.red
                            ) {
                                print("Deleted")
                            },
                            SwipeableListCell.SwipeAction(
                                title: "Archive",
                                icon: "archivebox.fill",
                                color: Color.blue
                            ) {
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
                } header: {
                    ListSectionHeader(
                        title: "Swipeable Cells",
                        subtitle: "Swipe for actions"
                    )
                }
                
                // Reorderable List Section
                Section {
                    ForEach(items, id: \.self) { item in
                        ReorderableListCell(
                            icon: "circle.fill",
                            title: item,
                            subtitle: "Drag to reorder",
                            iconColor: .blue
                        )
                    }
                    .onMove { source, destination in
                        items.move(fromOffsets: source, toOffset: destination)
                    }
                } header: {
                    ListSectionHeader(
                        title: "Reorderable List",
                        subtitle: "Long press and drag to reorder"
                    )
                }
            }
            .navigationTitle("List Cell Components")
            .toolbar {
                EditButton()
            }
        }
    }
}

// MARK: - All Components View
struct AllComponentsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    // Overview Section
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(
                            title: "Card & List UI Pack",
                            subtitle: "Polished cards and list cells for dashboards and feeds"
                        )
                        
                        Text("A comprehensive collection of beautiful, reusable SwiftUI components for iOS apps. Perfect for dashboards, feeds, and modern app interfaces.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    }
                    .padding(.top)
                    
                    // Features List
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(
                            title: "Features",
                            subtitle: "What's included in this pack"
                        )
                        
                        VStack(alignment: .leading, spacing: 8) {
                            FeatureRow(icon: "chart.bar.fill", text: "Info/stat cards")
                            FeatureRow(icon: "cart.fill", text: "Product cards with price & CTA")
                            FeatureRow(icon: "person.fill", text: "Profile list cells")
                            FeatureRow(icon: "arrow.left.arrow.right", text: "Swipe actions")
                            FeatureRow(icon: "arrow.up.arrow.down", text: "Reorderable lists")
                            FeatureRow(icon: "photo.fill", text: "AsyncImage cell with placeholder")
                            FeatureRow(icon: "textformat", text: "Section headers")
                        }
                        .padding(.horizontal)
                    }
                    
                    // Quick Preview Cards
                    SectionHeader(
                        title: "Quick Preview",
                        subtitle: "See components in action"
                    )
                    
                    HStack(spacing: 16) {
                        InfoStatCard(
                            title: "Components",
                            value: "7+",
                            icon: "square.grid.2x2.fill",
                            iconColor: .blue
                        )
                        
                        InfoStatCard(
                            title: "SwiftUI",
                            value: "100%",
                            subtitle: "Native components",
                            icon: "swift",
                            iconColor: .orange
                        )
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("UI Pack Overview")
        }
    }
}

// MARK: - Feature Row
struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.accentColor)
                .frame(width: 24)
            Text(text)
                .font(.body)
        }
    }
}
