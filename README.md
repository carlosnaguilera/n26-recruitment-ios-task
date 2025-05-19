# 📱 N26 iOS Code Challenge – Crypto Assets App

This iOS app was built using Swift 6.1, SwiftUI, UIKit (a little) and a modular Clean Architecture approach. It presents a list of crypto assets, lets users view asset details, and manage a list of favourites. The focus is on scalability, testability, and clean separation of concerns.

## 🚀 What the App Does

The app consists of two main tabs:

- **Assets**: Shows the top or bottom 10 assets based on 24h price change. Each asset displays its name, symbol, price (EUR), and percentage change. Tapping an asset opens a detail view with more info and a button to add/remove it from favourites.

- **Favourites**: Lists all favourite assets, including their name, symbol, price, and market cap.

To respect the CoinCap API's limited monthly request quota, the app fetches only the first 100 assets (out of the available 2000), which enough for displaying the top/bottom 10 performers.

## 🧱 Modules Overview

- **Domain**: Defines business logic and core entities like `Asset`. It declares use cases and repository interfaces that drive the app's behavior.

- **Data**: Handles networking, caching, and data transformation. Implements repositories that fetch and map remote API data to domain models. Favourites are stored in `UserDefaults`.

- **DesignTokens**: Centralizes UI constants such as spacing, colors, corner radius, and icons. This enables consistent styling and theme customization across the app.

- **Assets**: Contains all asset-related UI. Built using SwiftUI with MVVM, it provides reusable views, view models, and utilities like `AssetsFactory`, `ViewState`, and `StatefulView`.

- **App Layer**: A minimal UIKit shell that sets up the tab bar interface and hosts the modular feature views.

## ✨ Key Features

- ✅ Swift 6.1 with strict concurrency checking
- ✅ Modular Clean Architecture with MVVM
- ✅ SwiftUI UI with UIKit integration
- ✅ Design tokens for theming and layout consistency
- ✅ Snapshot testing support
- ✅ Localized formatting for prices and percentages
- ✅ Lightweight, with no third-party libraries (just SnapshotTesting for snapshot unit tests)
- ✅ iOS 15+ support

## 🧪 Notes

- Views use dedicated state types for testability and clarity
- Navigation is ID-based to avoid coupling between screens
- Localization is handled via `.xcstrings` at the app level. This keeps localized strings accessible to all features without adding module dependencies.  
- The architecture promotes testability through the consistent use of protocols and clear module boundaries.

