# Card & List UI Pack

<div align="center">

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0+-green.svg)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)

**Polished cards and list cells for dashboards and feeds**

A comprehensive collection of beautiful, reusable SwiftUI components for iOS apps. Perfect for dashboards, feeds, and modern app interfaces.

[Features](#features) • [Installation](#installation) • [Usage](#usage) • [Components](#components) • [Examples](#examples)

</div>

---

## ✨ Features

- 📊 **Info/stat cards** - Display key metrics and statistics with beautiful gradients
- 🛒 **Product cards with price & CTA** - Ready-to-use product cards with call-to-action buttons
- 👤 **Profile list cells** - User profile cells with online status indicators
- ↔️ **Swipe actions** - Native iOS swipe gestures for list actions
- ↕️ **Reorderable lists** - Drag-and-drop list reordering support
- 🖼️ **AsyncImage cell with placeholder** - Image loading with beautiful placeholders
- 📑 **Section headers** - Clean section headers for organizing content

## 📦 Installation

### Swift Package Manager

1. In Xcode, go to **File** → **Add Packages...**
2. Enter the repository URL:
   ```
   https://github.com/Sabbirhossain07/CardAndListUIPack.git
   ```
3. Select the version you want to use
4. Click **Add Package**

### Manual Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Sabbirhossain07/CardAndListUIPack.git
   ```
2. Drag the `CardAndListUIPack` folder into your Xcode project
3. Make sure "Copy items if needed" is checked

## 🚀 Usage

### Import the Package

```swift
import SwiftUI
// Components are already part of the package
```

### Quick Start

```swift
import SwiftUI

struct MyView: View {
    var body: some View {
        InfoStatCard(
            title: "Total Users",
            value: "12.5K",
            subtitle: "+12% from last month",
            icon: "person.3.fill",
            iconColor: .blue
        )
    }
}
```

## 📚 Components

### Cards

#### InfoStatCard

Display key metrics and statistics with customizable icons and gradients.

```swift
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
```

#### ProductCard

Beautiful product cards with images, prices, and call-to-action buttons.

```swift
ProductCard(
    imageName: "iphone",
    title: "iPhone 15 Pro",
    description: "Latest flagship with A17 Pro chip",
    price: "$999",
    originalPrice: "$1,199",
    ctaTitle: "Add to Cart",
    onCTATap: {
        // Handle add to cart
    }
)
```

### List Cells

#### ProfileListCell

User profile cells with online status and customizable accessories.

```swift
ProfileListCell(
    imageName: "person.circle.fill",
    name: "John Doe",
    subtitle: "@johndoe",
    detail: "Active 2 hours ago",
    isOnline: true,
    accessoryType: .badge("3")
)
```

#### AsyncImageCellModern

List cells with async image loading and placeholder support.

```swift
AsyncImageCellModern(
    imageURL: URL(string: "https://example.com/image.jpg"),
    title: "Beautiful Landscape",
    subtitle: "Nature photography at its finest",
    placeholder: "photo",
    placeholderColor: .gray
)
```

#### SwipeableListCell

List cells with native iOS swipe actions.

```swift
SwipeableListCell(
    leadingActions: [
        SwipeableListCell.SwipeAction(
            title: "Pin",
            icon: "pin.fill",
            color: .yellow
        ) {
            // Handle pin action
        }
    ],
    trailingActions: [
        SwipeableListCell.SwipeAction(
            title: "Delete",
            icon: "trash.fill",
            color: .red
        ) {
            // Handle delete action
        }
    ]
) {
    // Your cell content
    HStack {
        Text("Swipe me!")
        Spacer()
    }
}
```

#### ReorderableListCell

Cells designed for reorderable lists.

```swift
List {
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
}
.toolbar {
    EditButton()
}
```

### Section Headers

#### SectionHeader

Beautiful section headers for organizing content.

```swift
SectionHeader(
    title: "Featured Products",
    subtitle: "Handpicked for you",
    actionTitle: "See All"
) {
    // Handle see all action
}
```

#### ListSectionHeader

Section headers styled for use in Lists.

```swift
List {
    Section {
        // Your list items
    } header: {
        ListSectionHeader(
            title: "List Section",
            subtitle: "With subtitle"
        )
    }
}
```

## 🎨 Examples

The project includes a comprehensive demo app showcasing all components:

- **Cards Tab**: View all card components in action
- **List Cells Tab**: Explore list cell components
- **All Tab**: Overview of all features

Run the app to see live examples of each component!

## 📁 Project Structure

```
CardAndListUIPack/
├── Components/
│   ├── Cards/
│   │   ├── InfoStatCard.swift
│   │   └── ProductCard.swift
│   ├── ListCells/
│   │   ├── ProfileListCell.swift
│   │   ├── AsyncImageCell.swift
│   │   ├── SwipeableListCell.swift
│   │   └── ReorderableListCell.swift
│   └── SectionHeader.swift
├── ContentView.swift
└── CardAndListUIPackApp.swift
```

## 🎯 Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.9+

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Sabbir Hossain**

- GitHub: [@Sabbirhossain07](https://github.com/Sabbirhossain07)

## 🙏 Acknowledgments

- Built with SwiftUI
- Inspired by modern iOS design patterns
- Created for the iOS developer community

## ⭐ Show Your Support

If you find this project helpful, please give it a ⭐ on GitHub!

---

<div align="center">

Made with ❤️ using SwiftUI

</div>

