# 📂 Assets Module

The `Assets` module is responsible for presenting asset-related information using **SwiftUI**. It follows the **MVVM** design pattern and is organized to support modularity, separation of concerns, and scalability. This module handles the UI logic for listing assets, displaying their details, and managing favourites.

---

## Key Responsibilities

1. **Assets List**:
   - Displays a list of cryptocurrency assets with their name, symbol, price, and price change percentage.
   - Supports navigation to the asset details screen.
   - Allows switching between the **10 best** and **10 worst** performing assets based on price change percentage over the last 24 hours.

2. **Favourites List**:
   - Displays a list of user-favourited assets.
   - Allows users to manage their favourites.

3. **Asset Details**:
   - Displays detailed information about a specific asset, including its name, symbol, and price.
   - Allows users to toggle the favourite status of the asset.

---

## Components

### 🖼 Views

- **`AssetsList`**:
  - Displays a list of all assets.
  - Uses `AssetsList.ViewModel` to manage state and handle user interactions.
  - Includes a picker to toggle between the **best** and **worst** performing assets.

- **`FavoritesList`**:
  - Displays a list of favourited assets.
  - Uses `FavoritesList.ViewModel` to manage state and handle user interactions.

- **`AssetDetailsView`**:
  - Displays detailed information about a specific asset.
  - Uses `AssetDetailsView.ViewModel` to manage state and handle user interactions.

### 🛠 Utilities

- **`AssetsFactory`**:
  - A factory responsible for creating views and injecting dependencies.
  - Provides methods like `makeAssetsListView()` and `makeFavoriteAssetsListView()`.

- **`AssetsRenderer`**:
  - A helper responsible for transforming `Asset` domain entities into view-specific states (e.g., `AssetListItem.State`, `FavoritesListItem.State`, `AssetDetailsView.AssetDetailsContent`).

- **`StatefulView`**:
  - A wrapper view for handling loading, success, and error states.

- **`ViewState`**:
  - An enum used to represent the state of a view (e.g., `.loading`, `.loaded`, `.error`).

---

## Features

- ✅ **SwiftUI-based UI**: All views are implemented using SwiftUI for modern, declarative UI development.
- ✅ **MVVM Pattern**: Each view has a dedicated `ViewModel` to manage state and logic.
- ✅ **Theming Support**: Integrates with the `DesignTokens` module for consistent spacing, colors, and corner radius.
- ✅ **Localized Formatting**: Fully localized formatting for prices and percentages.
- ✅ **Navigation**: Supports navigation from the assets list to the details screen.
- ✅ **Snapshot Testing**: Includes snapshot tests for visual consistency.
- ✅ **Best/Worst Toggle**: Allows users to switch between the **10 best** and **10 worst** performing assets in the list.

---

## Example Workflow

1. **Assets List**:
   - The `AssetsList` view fetches a list of assets using the `GetAssets` use case.
   - The list is rendered using `AssetsRenderer` to format the data.
   - Users can toggle between the **best** and **worst** performing assets using a picker.

2. **Favourites List**:
   - The `FavoritesList` view fetches a list of favourited assets using the `GetFavorites` use case.
   - The list is rendered using `AssetsRenderer`.

3. **Asset Details**:
   - The `AssetDetailsView` fetches detailed information about a specific asset using the `GetAsset` use case.
   - The user can toggle the favourite status of the asset using the `SetAssetFavoriteStatus` use case.

---

## Dependencies

- **Domain Module**:
  - Provides the `Asset` entity and use cases like `GetAssets`, `GetFavorites`, and `SetAssetFavoriteStatus`.

- **Data Module**:
  - Provides repositories for fetching and caching asset data.

- **DesignTokens Module**:
  - Provides theming support for consistent UI design.

---

## Example Usage

### Creating the Assets List View

```swift
let assetsListViewController = AssetsFactory.makeAssetsListView()
```