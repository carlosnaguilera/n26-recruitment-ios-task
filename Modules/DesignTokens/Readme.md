# 🎨 DesignTokens Module

The `DesignTokens` module provides a centralized and reusable set of design tokens for the application. These tokens ensure consistent styling and theming across the app, making it easier to maintain and scale the UI.

## Key Responsibilities

1. **Theming**:
   - Exposes a `Theme` protocol and a default implementation (`DefaultTheme`) to provide consistent access to design tokens like spacing, corner radius, and colors.
   - The theme is injected into SwiftUI views via the `Environment` for seamless access.

2. **Design Tokens**:
   - Provides predefined values for spacing, corner radius, colors, and icons to ensure consistency across the app's UI.

---

## Components

### 🧩 Spacing

- **`Spacing` Protocol**:
  - Defines standard spacing values for margins and paddings.
  - Properties:
    - `small100`: 4 points
    - `small200`: 8 points
    - `small300`: 16 points

- **`DefaultSpacing`**:
  - Implements the `Spacing` protocol with default values.

### 🟦 Corner Radius

- **`CornerRadius` Protocol**:
  - Defines standard corner radius values for UI elements.
  - Properties (example, if implemented):
    - `small`: Small corner radius.
    - `medium`: Medium corner radius.
    - `large`: Large corner radius.

- **`DefaultCornerRadius`**:
  - Implements the `CornerRadius` protocol with default values.

### 🎨 Colors

- **`Colors` Protocol**:
  - Defines reusable colors for positive/negative states and UI themes.
  - Properties (example, if implemented):
    - `primary`: Primary color for the app.
    - `secondary`: Secondary color.
    - `positive`: Color for positive states.
    - `negative`: Color for negative states.

- **`DefaultColors`**:
  - Implements the `Colors` protocol with default values.

### 🧩 Icons

- **`Icons` Enum**:
  - Provides UIKit-based icons for common use cases.
  - Examples:
    - `assetsTab`: Icon for the "Assets" tab.
    - `favoritesTab`: Icon for the "Favourites" tab.

### 🌈 Theme

- **`Theme` Protocol**:
  - Combines `Spacing`, `CornerRadius`, and `Colors` into a single interface.
  - Properties:
    - `spacing`: Access to spacing values.
    - `cornerRadius`: Access to corner radius values.
    - `colors`: Access to color values.

- **`DefaultTheme`**:
  - Implements the `Theme` protocol with default values for spacing, corner radius, and colors.

- **Environment Integration**:
  - The `Theme` is injected into SwiftUI views via the `Environment` using the `theme` property in `EnvironmentValues`.

---

## Features

- 📏 **Spacing**: Predefined values for consistent layout margins and paddings.
- 🟦 **Corner Radius**: Standardized corner radius values for UI elements.
- 🎨 **Colors**: A set of reusable colors for positive/negative states and UI themes.
- 🧩 **Icons**: UIKit-based icons for common use cases.
- 🌈 **Theme Support**: Provides a `Theme` protocol and a `DefaultTheme` implementation for consistent theming across the app.

---

## Example Usage

### Accessing the Theme in SwiftUI

```swift
struct ExampleView: View {
    @Environment(\.theme) private var theme

    var body: some View {
        VStack(spacing: theme.spacing.small200) {
            Text("Hello, World!")
                .padding(theme.spacing.small300)
                .background(theme.colors.primary)
                .cornerRadius(theme.cornerRadius.small)
        }
    }
}