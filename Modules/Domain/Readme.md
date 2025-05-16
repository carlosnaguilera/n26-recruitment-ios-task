# 📦 Domain Module

The `Domain` module defines the core business logic and domain entities for the application. It serves as the foundation of the app's architecture, ensuring that the business rules are independent of external frameworks or data sources.

## Key Responsibilities

1. **Entities**:
   - Defines the core data structures used throughout the app, such as `Asset`.
   - These entities are designed to be simple, immutable, and reusable across different layers.

2. **Use Cases**:
   - Encapsulates the application's business logic, such as managing assets and their favourite statuses.
   - Use cases are implemented as standalone operations, making them easy to test and reuse.

3. **Repositories**:
   - Provides protocols for interacting with data sources (e.g., remote APIs, local storage).
   - The repository pattern ensures that the domain layer is decoupled from the data layer, enabling flexibility and testability.

---

## Components

### 🧩 Entities

- **`Asset`**:
  - Represents a cryptocurrency or financial asset.
  - Includes properties such as `id`, `name`, `symbol`, `price`, and `isFavourite`.

### 🔁 Use Cases

- **`GetAssets`**:
  - Fetches a list of assets from the repository.
  - **Behavior**:
    - If `refresh` is `false`, the use case first attempts to retrieve assets from the `InMemoryAssetRepository`. If cached assets are available, they are returned immediately.
    - If `refresh` is `true` or no cached assets are available, the use case fetches fresh data from the `RemoteAssetRepository` and updates the in-memory cache.
  - **Repositories Used**:
    - `RemoteAssetRepository`: Fetches assets from a remote API.
    - `InMemoryAssetRepository`: Provides in-memory caching for assets.

- **`GetAsset`**:
  - Fetches a single asset by its `id` from the repository.
  - **Repositories Used**:
    - `InMemoryAssetRepository`: Retrieves the asset from in-memory storage.

- **`IsAssetWithIdFavorite`**:
  - Checks if an asset with a given `id` is marked as a favourite.
  - **Repositories Used**:
    - `LocalFavoriteRepository`: Checks the favourite status of an asset.

- **`SetAssetFavoriteStatus`**:
  - Updates the favourite status of an asset by adding or removing it from the favourites list.
  - **Repositories Used**:
    - `LocalFavoriteRepository`: Adds or removes the asset from the favourites list.

- **`GetFavorites`**:
  - Fetches a list of favourite assets by filtering the full list of assets based on their favourite status.
  - **Repositories Used**:
    - `LocalFavoriteRepository`: Retrieves the list of favourite asset IDs.
    - `RemoteAssetRepository` and `InMemoryAssetRepository`: Fetches the full list of assets to filter favourites.

### 📜 Repositories

- **Protocols**:
  - `AssetRepository`: Defines methods for fetching assets and updating their favourite status.
  - `LocalFavoriteRepository`: Manages the persistence of favourite assets.
  - `InMemoryAssetRepository`: Provides in-memory caching for assets.
  - `RemoteAssetRepository`: Fetches assets from a remote API.

---

## Features

- 🧩 **Entities**: Core data structures like `Asset` that represent the app's business objects.
- 🔁 **Use Cases**: Encapsulated business logic for managing assets and favourites.
- 📜 **Repositories**: Protocols for data access, decoupling the domain layer from external dependencies.

---

## Example Workflow

1. **Fetching Assets**:
   - The `GetAssets` use case interacts with the `RemoteAssetRepository` and `InMemoryAssetRepository` to fetch a list of assets.
   - If `refresh` is `false`, cached assets are returned if available. Otherwise, fresh data is fetched from the remote repository.

2. **Fetching a Single Asset**:
   - The `GetAsset` use case retrieves a specific asset by its `id` from the `InMemoryAssetRepository`.

3. **Checking Favourite Status**:
   - The `IsAssetWithIdFavorite` use case checks if an asset is marked as a favourite using the `LocalFavoriteRepository`.

4. **Toggling Favourites**:
   - The `SetAssetFavoriteStatus` use case updates the `isFavourite` property of an `Asset` using the `LocalFavoriteRepository`.

5. **Fetching Favourites**:
   - The `GetFavorites` use case filters the list of assets to return only those marked as favourites using the `LocalFavoriteRepository` and asset repositories.

---

## Benefits

- **Testability**:
  - The domain layer is highly testable due to its independence from external frameworks.
  - Use cases and entities can be tested in isolation.

- **Flexibility**:
  - The repository pattern allows the data source to be swapped or extended without affecting the domain logic.

- **Scalability**:
  - The modular design makes it easy to add new use cases or entities as the app evolves.

---

## Notes

- The `Domain` module is intentionally lightweight and focused solely on business logic.
- It has no dependencies on external frameworks, ensuring that it remains portable and reusable.