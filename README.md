# “Mini SuperPay Checkout App” - iOS Application


## Overview

**Key Technical Achievements**:
- Clean Architecture implementation (MVVM + Repository patterns + Coordinator patterns)
- Modern concurrency with async/await for seamless user experience
- Real Mockfly API integration with network layer
- Type-safe navigation system preventing runtime navigation errors
- Persistent cart storage ensuring data survives app restarts using UserDefaults data persistance
- Comprehensive error handling with user-friendly feedback
- Real product images loaded asynchronously from Unsplash
- Unit testing with mock-based architecture 
- Full localization support for multi-language capability(Currently supported English only)

---

## Features 

- Product browsing with async image loading from Mockfly API
- Shopping cart with quantity management and persistence
- Checkout flow with real API integration (GET/products) and (POST /checkout)
- Wallet balance validation and deduction
- Dynamic API response handling (success/failure scenarios)
- Comprehensive loading states and error handling

---

## Architecture

Layered Architecture: Presentation → Domain → Core  
Patterns: MVVM + Repository + Coordinator  
State Management: @Observable with generic AsyncLoadingState<T>  
Network: Modern async/await with URLSession
API: Mockfly integration for products and checkout
Concurrency: Swift structured concurrency throughout

---

## Requirements: 
Xcode 15.0+ (didn't check lower version), iOS 17.0+, Swift 5 

## My development envirnment: 
Xcode 26.1.1

## Testing device:
iPhone 13(iOS 18.7.1), Simulator iPhone Pro

## Repository
GitHub repository link: 
https://github.com/uddin-nasir-jp/Mini-Super-Pay.git

## Installation

Clone the repository:
```
git clone https://github.com/uddin-nasir-jp/Mini-Super-Pay.git
cd Mini-Super-Pay
open MiniSuperPay.xcodeproj
```

Press Command+R to build and run the application.
No external dependencies or CocoaPods required.


## Testing


Test Coverage:
- Focus on ViewModels and Repositories
- Tests cover a view model (ProductViewModel) and a repository (CheckoutRepository)


## Known Limitations and Trade-offs

Architecture Decisions:

0. Backend api integration is not enough
1. UserDefaults for Cart Persistence
   Pro: Simple implementation, sufficient for small datasets
   Con: Not ideal for large datasets or complex queries
   Better Alternative: SwiftData or CoreData for production scale

2. Mockfly API Integration (Now Implemented)
   Current: Production-ready async/await network layer with Mockfly
   Pro: Real API calls, modern Swift concurrency, type-safe endpoints
   Trade-off: Mock service still available for offline testing

3. In-Memory Wallet Storage
   Pro: Fast access, simple implementation
   Con: Data lost on app termination, not secure
   Better Alternative: Keychain for secure persistent storage


## TODO and Future Enhancement

- Add image caching with NSCache for better performance
- Implement retry logic with exponential backoff for failed requests
- All device compatibity support (Ensured for SE and Pro devices)
- Full dark mode colors and contrasts (Mostly handled)
- Add product search and filter functionality
- Implement order history and past purchases view
- Add user favorites or wishlist feature
- Improve accessibility with VoiceOver support
- Add complete localization for multiple languages (Currently English only but has scope to extend)


## Author

Nasir Uddin
GitHub: https://github.com/uddin-nasir-jp

## License
N/A
