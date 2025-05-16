## 🛠 Tech Stack

- **Swift**: 6.1  
  ✅ Compiles cleanly with **strict concurrency checking enabled by default** (no `Sendable` or actor-isolation errors)  
- **iOS**: Minimum deployment target iOS 16  
- **UI Framework**: SwiftUI + UIKit integration  
- **Architecture**: Clean Architecture + MVVM  


## 🧱 Architecture Overview

The project follows a modular, layered architecture inspired by **Clean Architecture**.
Each module is designed to be loosely coupled, highly testable, and easy to evolve as the application grows.

 It is structured into the following modules:

---

### 📦 Domain Module

The `Domain` module defines the core business logic and domain entities for the application. It provides use cases, repositories, and entities to manage and interact with assets and their favourite statuses.

#### Features

- 🧩 **Entities**: Defines the `Asset` entity, which represents a cryptocurrency or financial asset  
- 🔁 **Use Cases**: Implements core business logic for managing assets and their favourite statuses  
- 📜 **Repositories**: Provides protocols for interacting with in-memory, local, and remote data sources  

---

### 📦 Data Module

The `Data` module provides data handling and repository services. It includes functionality for fetching, mapping, and caching cryptocurrency asset data from a remote API, as well as managing user favourites.

#### Features

- 📡 **Fetch** cryptocurrency assets and exchange rates from a remote API  
- 🔄 **Map** raw data models to domain models for use in the application  
- ⚡️ **Cache** assets in memory for quick access  
- 💾 **Manage** user favourite assets using `UserDefaults`  
- 🧪 **Mock Data Downloader** for testing and development  
  > ℹ️ *Due to issues with the real API, the app currently uses the mock downloader as the main data source*

---

### 🎨 DesignTokens Module

The `DesignTokens` package provides a centralized and reusable set of design tokens for iOS applications. These tokens include spacing, corner radius, colors, and icons, which help maintain consistency across the app's UI.

#### Features

- 📏 **Spacing**: Predefined values for consistent layout margins and paddings  
- 🟦 **Corner Radius**: Standardized corner radius values for UI elements  
- 🎨 **Colors**: A set of reusable colors for positive/negative states and UI themes  
- 🧩 **Icons**: UIKit-based icons for common use cases  
- 🧩 **Theme support**: The module exposes a `Theme` protocol and provides a `DefaultTheme` implementation, injected via the SwiftUI `Environment`.  
  This allows views to access consistent design tokens (spacing, corner radius, colors) while remaining fully testable and overrideable for theming or previews.

> 🖼 Although icons are not typically considered design tokens, they are included in the `DesignTokens` module for simplicity.  
> In larger projects, icons would ideally live in their own module, but in this case, a separate package felt unnecessary given the app's scope.


---

### 📂 Assets Module

The `Assets` module is focused on presenting asset-related information using **SwiftUI**, following the **MVVM** design pattern. It is organized by feature and supports modularity, separation of concerns, and scalability.

This module contains all the UI logic for listing assets, displaying their details, and managing favourites.

##### 🛠 Utilities

- `AssetsFactory`: Central place to create views, useful for dependency injection or module interfacing  
- `AssetsRenderer`: Helper responsible for building asset rows/views with the right styling and structure  
- `StatefulView`: Wrapper view for loading, success, and error states  
- `ViewState`: Enum used to represent view states (e.g., loading, loaded, error)

#### ✨ Features

- ✅ SwiftUI-based UI components with modular structure  
- ✅ MVVM pattern for each screen/view  
- ✅ Fully localized formatting for price and change percent  
- ✅ Theming support via `DesignTokens`  
- ✅ Loading and error states handled via `StatefulView` and `ViewState`  
- ✅ Snapshot testing support for visual consistency (snapshots are recorded using **iPhone 16**)

- 🧠 Each view has a dedicated **state type** used to drive the UI, declared as a `@Published` property in its ViewModel.  
  This separation of state and logic improves testability and prepares the app for a future migration to a unidirectional architecture such as **The Composable Architecture (TCA)**.
  
- 🧩 While the app has two tabs ("Assets" and "Favourites"), they share data structures.  
  To reduce duplication and keep things simple, both are implemented within the `Assets` module.  
  In larger projects, they could be split into separate modules if needed.

- 🔗 Navigation from the assets list to the details screen is done by passing the asset's `id`, not the full model.  
  This avoids coupling to domain entities and allows screens to work independently — which is key for supporting deeplinks or previews.

---

### 🚀 Application Layer

The application layer is intentionally minimal and not organized as a dedicated module. It contains the main entry point and the `HomeViewController`, which sets up the tab bar interface.

#### Components

- **AppDelegate / SceneDelegate**: Standard UIKit lifecycle setup for iOS 16.
- **HomeViewController**: A `UITabBarController` subclass that manages the two main tabs:
  - **Assets**
  - **Favourites**

All UI and business logic is delegated to modular Swift packages under `Modules/`.

#### Notes

- 🌐 The app uses an `.xcstrings` file for localization, included in the main app target.  
  This keeps localized strings accessible to all features without adding module dependencies.  
  The decision was made when initially considering splitting tabs into separate feature modules.

---

### 🧪 Testability

The architecture promotes testability through the consistent use of protocols and clear module boundaries. Each feature is structured in a way that makes it straightforward to introduce and scale unit tests as needed. Snapshot tests are also used for key UI components.
The use of dependency injection, protocol-oriented design, and clearly defined view states also supports easier snapshot testing and unit testing.

---

### 🧭 If I Had More Time...

If time permitted, here are a few things I would consider adding or improving:

- 🧠 **Review Swift 6 compatibility** as I'm not sure it would really work
- 🔍 **Search functionality** for filtering assets by name  
- 🧪 **Higher test coverage**
- 💾 **Persisting favourite assets** using a more robust solution like `CoreData` (potentially synced with `CloudKit`)  
- ⚙️ **CI integration** to automate test execution and snapshot verification (XcodeCloud or GitHub actions)
- 🧹 **SwiftLint integration** to enforce code style and maintain consistency across the project
- 👁️ **Add previews** for all the views
- 🛠️ **Review inits of views** to remove unnecessary public access and update `AssetsFactory` accordingly 

These additions would help take the app closer to production-level quality and scalability, while keeping it maintainable and clean for team collaboration.




