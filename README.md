# Movie App

Movie App is an iOS application developed with SwiftUI and follows the MVVM (Model-View-ViewModel) design pattern to structure the code.

## Features

- **Developed with SwiftUI**: The user interface is built using SwiftUI for a declarative and efficient design.
  
- **Persistence with UserDefaults**: Users can save their favorite movies using `UserDefaults` for persistence across sessions.

- **Networking with Combine**: Combine is used for handling reactive network requests, fetching data from the OMDBAPI to list and display movies, series, and games.

- **OMDBAPI Integration**: The app fetches data from the OMDBAPI to display a list of popular movies, series, and games with details like title, year, rating, etc.

- **Kingfisher for Image Loading**: The app uses the `Kingfisher` library for efficient image handling, including image loading and caching for movie posters.

- **Binary Search Algorithm**: A binary search algorithm is implemented to optimize search performance, ensuring the app remains fast even with large datasets.

- **CacheManager**: The app includes a `CacheManager` to avoid redundant API calls for movies that have already been viewed.

- **Localizable Support**: Currently supports English, with the plan to scale to multiple languages in the future using `Localizable`.

- **Dark Mode Support**: The app is fully compatible with iOS Dark Mode, adjusting the UI colors automatically based on user preferences.

## App Icon

The app icon was generated with AI. You can view it below:
<img src="[https://your-image-url.type](https://i.ibb.co/wsVyYvy/Screenshot-2024-12-03-at-10-54-34.png)" width="100" height="100">


## Requirements

- iOS 17.2 or later
- Xcode 15.2 or later
- Swift Package Manager for dependency management

## Dependencies

- **Kingfisher**: For efficient image handling, including caching and loading.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/camiloibarrayepes/OmdbMovies.git
   ```

2. Open de project in Xcode.

3. Run the app in a simulator or real device.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
