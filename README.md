# ShelfScan

[![Swift Version](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![iOS Version](https://img.shields.io/badge/iOS-16.6+-blue.svg)](https://developer.apple.com/ios/)
[![SwiftUI](https://img.shields.io/badge/UI-SwiftUI-green.svg)](https://developer.apple.com/xcode/swiftui/)
[![Core Data](https://img.shields.io/badge/Persistence-Core%20Data-red.svg)](https://developer.apple.com/documentation/coredata)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A modern iOS application built with SwiftUI that allows users to scan ISBN codes, manage book information, and maintain a personal digital library. This project demonstrates advanced iOS development patterns including MVVM architecture, dependency injection, comprehensive testing, and Core Data integration.

## Features

| Feature | Description | Status |
|---------|-------------|--------|
| 📱 **Launch Screen** | Animated splash screen with smooth transitions | ✅ |
| 📷 **ISBN Scanner** | Real barcode scanning with simulator fallback | ✅ |
| ✏️ **Manual Entry** | Form-based book data input with validation | ✅ |
| 💾 **Data Persistence** | Core Data integration for local storage | ✅ |
| 📚 **Library View** | Browse and manage saved books | ✅ |
| 🗑️ **Book Management** | Edit mode with deletion capabilities | ✅ |
| ✨ **Form Validation** | Real-time validation with Strategy pattern | ✅ |
| 🎨 **Modern UI** | SwiftUI with custom components and animations | ✅ |

## Architecture & Design Patterns

### MVVM Architecture
The application follows the Model-View-ViewModel pattern with clear separation of concerns:

```
├── Models/
│   └── BookModel.swift           # Data model
├── ViewModels/
│   └── BookFormViewModel.swift   # Business logic & state management
├── Views/
│   ├── ScanView.swift           # Main scanning interface
│   ├── BookFormView.swift       # Form for book details
│   ├── LibraryView.swift        # Library management
│   └── Reusables/               # Reusable UI components
├── Persistence/
│   ├── CoreDataStack           # Core Data configuration
│   └── BookEntity.swift        # Core Data entity
└── Validators/
    └── Strategy Pattern        # Field validation
```

### Key Design Patterns

**Strategy Pattern (Validation)**
```swift
protocol FieldValidator {
    func validate(_ input: String) -> Bool
}

struct TitleValidator: FieldValidator { }
struct AuthorValidator: FieldValidator { }
struct ISBNValidator: FieldValidator { }
```

**Observer Pattern (Combine)**
- Reactive UI updates using `@Published` properties
- Form state management with real-time validation
- Data flow between ViewModels and Views

**Dependency Injection**
- Constructor injection for ViewModels
- Testable architecture with mock dependencies
- Clean separation of concerns

## Core Data Integration

The app uses Core Data for persistent storage with a clean entity design:

```swift
@objc(BookEntity)
public class BookEntity: NSManagedObject {
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var isbn: String?
    
    func toModel() -> Book { }
}
```

Features:
- In-memory context for testing
- Automatic data fetching and synchronization
- Error handling for Core Data operations

## Testing

The project maintains **>85% test coverage** on business logic with a comprehensive testing strategy:

### Test Structure
```
BookShelfTests/
├── BookFormViewModelTests.swift    # ViewModel business logic
├── Validators/                     # Strategy pattern validation
└── Mocks/                         # Test doubles
    ├── AlwaysValidValidator.swift
    └── AlwaysInvalidValidator.swift
```

### Testing Approach
- **Test-Driven Development (TDD)** for core business logic
- **Unit Tests** for ViewModels with dependency injection
- **Strategy Pattern Testing** for validation logic
- **Core Data Testing** with in-memory persistent store
- **Mock Objects** for external dependencies

### Key Test Cases
```swift
func testCanSaveReturnsTrueWhenAllFieldsAreFilled()
func testSaveBookAddsBookIfValidationPasses()
func testFormIsResetAfterSave()
func testDeleteBookRemovesBook()
```

### Test Utilities
```swift
enum CoreDataTestHelper {
    static func makeInMemoryContext() -> NSManagedObjectContext
}
```

## Technical Specifications

- **Language**: Swift 5.0
- **UI Framework**: SwiftUI
- **Architecture**: MVVM with Dependency Injection
- **Data Persistence**: Core Data
- **Reactive Programming**: Combine
- **Testing Framework**: XCTest
- **Minimum iOS Version**: 16.6+
- **Xcode Version**: 16.3+

## Dependencies

- **CodeScanner** (2.5.2): Barcode scanning functionality

## Installation & Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/shelfscan.git
   cd shelfscan
   ```

2. **Open in Xcode**
   ```bash
   open BookShelf.xcodeproj
   ```

3. **Install Dependencies**
   - Dependencies are managed via Swift Package Manager
   - Xcode will automatically resolve packages on first build

4. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run
   - For testing: Press `Cmd + U`

## Project Structure

```
BookShelf/
├── App/
│   └── BookShelfApp.swift          # App entry point
├── Views/
│   ├── ScanView.swift              # Main interface
│   ├── BookFormView.swift          # Book details form
│   ├── LibraryView.swift           # Library management
│   ├── LaunchScreenView.swift      # Splash screen
│   └── Reusables/                  # Reusable components
│       ├── CustomTextField.swift
│       ├── GradientButton.swift
│       ├── BookCard.swift
│       └── EmptyStateView.swift
├── ViewModels/
│   └── BookFormViewModel.swift     # Main business logic
├── Models/
│   └── BookModel.swift             # Data structures
├── Persistence/
│   ├── PersistenceController.swift # Core Data stack
│   └── BookEntity.swift            # Core Data entity
├── Validators/
│   ├── FieldValidator.swift        # Strategy protocol
│   ├── TitleValidator.swift
│   ├── AuthorValidator.swift
│   └── ISBNValidator.swift
└── Managers/
    └── PermissionsManager.swift    # Camera permissions
```

## Future Enhancements

- [ ] **Cloud Sync**: iCloud integration for cross-device synchronization
- [ ] **Search & Filter**: Advanced search capabilities in library
- [ ] **Book Details**: Integration with book APIs for automatic metadata
- [ ] **Categories**: Organize books by genre or custom categories
- [ ] **Export**: PDF/CSV export functionality
- [ ] **Dark Mode**: Enhanced dark mode support
- [ ] **Accessibility**: VoiceOver and accessibility improvements
- [ ] **Widget**: iOS widget for quick library stats

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**ShelfScan** - Transforming physical libraries into digital experiences through modern iOS development practices.
