# 📦 Data Module

The `Data` module is responsible for handling all data-related operations, including fetching, mapping, and caching data. It acts as the bridge between the application's domain layer and external data sources, ensuring that raw data is transformed into meaningful domain entities.

---

## Key Responsibilities

1. **Fetching Data**:
   - The module fetches cryptocurrency asset data and exchange rates from a remote API using the `HTTPDataDownloader` protocol. This protocol abstracts the network layer, making it easy to replace or mock for testing.
   - The `Endpoint` protocol defines the structure of API requests, including paths, methods, headers, and query parameters.

2. **Mapping Data**:
   - Raw data models (`AssetDataModel`, `RateDataModel`, etc.) fetched from the API are mapped to domain entities (`Asset`) using the `AssetMapper`.
   - The mapper ensures that only valid and complete data is passed to the domain layer, filtering out any incomplete or invalid entries.

3. **Caching Data**:
   - Assets are cached in memory for quick access, reducing the need for repeated network calls.
   - User favourites are managed using `UserDefaults`, providing a lightweight solution for persistence.

4. **Environment Configuration**:
   - The `Environment` enum is used to manage API configurations for different build environments (e.g., `debug` and `release`).
   - It provides the base URL and API key for the application, ensuring that the correct configuration is used based on the build settings.
   - This abstraction allows for easy switching between environments and ensures that sensitive information like API keys is managed securely.

5. **Mock Data**:
   - The module includes mock data sources for testing and development. For example, mock JSON files (`assets_list_response.json`, `rates_response.json`) are used to simulate API responses when the real API is unavailable.

---

## Components

### **HTTPDataDownloader**

- **`HTTPDataDownloader` Protocol**:
  - Abstracts the network layer for fetching data over HTTP.
  - Default implementation uses `URLSession` for making API requests.

### **Endpoint**

- **`Endpoint` Protocol**:
  - Defines the structure of API requests, including paths, methods, headers, and query parameters.
  - Ensures consistency and reusability across different API endpoints.

### **AssetMapper**

- **`AssetMapper`**:
  - Maps raw data models (`AssetDataModel`, `RateDataModel`) into domain entities (`Asset`).
  - Calculates derived values like price and market cap in EUR.

### **Environment**

- **`Environment` Enum**:
  - Manages the application's API configuration for different build environments.
  - Properties:
    - `baseURL`: The base URL for the API.
    - `apiKey`: The API key for authentication.
  - Behavior:
    - Automatically selects the appropriate configuration based on the build settings (`debug` or `release`).

---

## Features

- 📡 **Fetch** cryptocurrency assets and exchange rates from a remote API.
- 🔄 **Map** raw data models to domain models for use in the application.
- ⚡️ **Cache** assets in memory for quick access.
- 💾 **Manage** user favourite assets using `UserDefaults`.
- 🌐 **Environment Configuration**: Provides a flexible and secure way to manage API configurations for different build environments.
- 🧪 **Mock Data Downloader** for testing and development.
  > ℹ️ *Due to issues with the real API, the app currently uses the mock downloader as the main data source.*

---

## Example Workflow

1. **Fetching Data**:
   - The `HTTPDataDownloader` fetches raw JSON data from the API.
   - The data is decoded into `AssetDataModel` and `RateDataModel` using `Codable`.

2. **Mapping Data**:
   - The `AssetMapper` combines `AssetDataModel` and `RateDataModel` to calculate derived values like price and market cap in EUR.
   - The resulting `Asset` entities are passed to the domain layer.

3. **Caching and Persistence**:
   - Assets are cached in memory for quick access.
   - User favourites are stored in `UserDefaults` for persistence across app launches.

4. **Environment Configuration**:
   - The `Environment` enum ensures that the correct API configuration is used based on the build settings.

---

## Notes

- The `Environment` enum provides a clean and secure way to manage API configurations, making it easy to switch between `debug` and `release` environments.
- This modular and testable design ensures that the `Data` module can be easily extended or replaced without affecting other parts of the application.