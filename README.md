# ClippedCornerShape

<div style="display: flex; justify-content: center; align-items: center; gap: 10px; width: 100%;">
  <img src="./screenshots/Simulator Screenshot.png" style="width: 200px; height: auto; object-fit: contain;">
  <img src="./screenshots/Simulator Screenshot 2.png" style="width: 200px; height: auto; object-fit: contain;">
</div>

## Overview

`ClippedCornerShape` is a flexible SwiftUI library that allows you to create custom shapes with clipped corners in various positions. This package provides a `Shape` and a `ViewModifier` that can be easily applied to any SwiftUI view to create unique, modern design elements.

## Features

- Custom corner clipping in four positions:
  - Top Left
  - Top Right
  - Bottom Left
  - Bottom Right
- Configurable clip dimensions
- Adjustable corner radius
- Simple, intuitive API
- Lightweight and easy to integrate

## Installation

### Swift Package Manager

1. In Xcode, go to File > Add Packages...
2. In the search bar, paste your GitHub repository URL
3. Select the package and click "Add Package"

### Manually

Clone the repository and drag the `ClippedCornerShape.swift` file into your Xcode project.

## Usage

### Basic Usage

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .clippedCorner(clipX: 100, clipY: 50)
    }
}
```

### Customization Options

```swift
// Customize clip position, dimensions, and corner radius
Image("example")
    .clippedCorner(
        clipX: 140,           // Horizontal clip extent
        clipY: 70,             // Vertical clip extent
        cornerRadius: 20,      // Corner arc radius
        position: .bottomLeft  // Clipped corner position
    )
```

## Parameters

### `clippedCorner` Modifier

- `clipX`: Horizontal extent of the clip
- `clipY`: Vertical extent of the clip
- `cornerRadius`: Radius of the corner arcs (default: 16)
- `position`: Position of the clipped corner (default: .bottomRight)

### Supported Positions

- `.topLeft`
- `.topRight`
- `.bottomLeft`
- `.bottomRight`

## Example

```swift
struct DemoView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 20) {}
                .frame(width: 350, height: 300)
                .background(
                    Material.regularMaterial
                )
                .clippedCorner(clipX: 100, clipY: 70, cornerRadius: 22, position: .bottomRight)
                .shadow(color: .gray.opacity(0.7), radius: 6, x: 6, y: 8)
                .padding(.horizontal)

            HStack {
                Button {} label: {
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 40, height: 40)
                            .shadow(color: .gray.opacity(0.7), radius: 6, x: 3, y: 2)

                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                Button {} label: {
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 40, height: 40)
                            .shadow(color: .gray.opacity(0.7), radius: 6, x: 3, y: 2)

                        Image(systemName: "checkmark")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.trailing)
        }
    }
}
```

## Requirements

- iOS 13.0+

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Author

Mehran
