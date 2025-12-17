//
//  AsyncImageCell.swift
//  CardAndListUIPack
//
//  Created by Sabbir Hossain on 17/12/25.
//

import SwiftUI

/// A beautiful list cell with async image loading and placeholder support
public struct AsyncImageCell: View {
    let imageURL: URL?
    let title: String
    let subtitle: String?
    let placeholder: String
    let placeholderColor: Color
    
    @State private var isLoading = true
    @State private var image: UIImage?
    
    /// Initialize an async image cell
    /// - Parameters:
    ///   - imageURL: URL of the image to load
    ///   - title: Main title text
    ///   - subtitle: Optional subtitle text
    ///   - placeholder: SF Symbol name for placeholder
    ///   - placeholderColor: Color for the placeholder icon
    public init(
        imageURL: URL?,
        title: String,
        subtitle: String? = nil,
        placeholder: String = "photo",
        placeholderColor: Color = .gray
    ) {
        self.imageURL = imageURL
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            // Async Image with Placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .frame(width: 80, height: 80)
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Image(systemName: placeholder)
                        .font(.title)
                        .foregroundColor(placeholderColor)
                }
            }
            
            // Text Content
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let url = imageURL else {
            isLoading = false
            return
        }
        
        isLoading = true
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let loadedImage = UIImage(data: data) {
                    await MainActor.run {
                        self.image = loadedImage
                        self.isLoading = false
                    }
                } else {
                    await MainActor.run {
                        self.isLoading = false
                    }
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }
}

// MARK: - SwiftUI AsyncImage Version (iOS 15+)
/// Alternative implementation using SwiftUI's built-in AsyncImage
public struct AsyncImageCellModern: View {
    let imageURL: URL?
    let title: String
    let subtitle: String?
    let placeholder: String
    let placeholderColor: Color
    
    /// Initialize an async image cell using SwiftUI's AsyncImage
    public init(
        imageURL: URL?,
        title: String,
        subtitle: String? = nil,
        placeholder: String = "photo",
        placeholderColor: Color = .gray
    ) {
        self.imageURL = imageURL
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            // Async Image with Placeholder
            Group {
                if let url = imageURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemGray6))
                                    .frame(width: 80, height: 80)
                                ProgressView()
                            }
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        case .failure:
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemGray6))
                                    .frame(width: 80, height: 80)
                                Image(systemName: placeholder)
                                    .font(.title)
                                    .foregroundColor(placeholderColor)
                            }
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                            .frame(width: 80, height: 80)
                        Image(systemName: placeholder)
                            .font(.title)
                            .foregroundColor(placeholderColor)
                    }
                }
            }
            
            // Text Content
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}

// MARK: - Preview
#Preview {
    List {
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
    }
    .listStyle(.plain)
}

