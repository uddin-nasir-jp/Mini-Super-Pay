# “Mini SuperPay Checkout App” - iOS Application

## Overview

Key Technical Achievements:
- Clean Architecture implementation with MVVM, Repository, and Coordinator patterns
- Modern concurrency using async/await for seamless user experience
- Type-safe navigation system preventing runtime navigation errors
- Persistent cart storage using UserDefaults ensuring data survives app restarts
- Comprehensive error handling with user-friendly feedback messages
- Real product images loaded asynchronously from Unsplash API
- Unit testing with mock-based architecture achieving 20% code coverage
- Full localization support for multi-language capability (English only currently)

## Features

Core Functionality:
- Browse products with async image loading from remote URLs
- Add/remove items from shopping cart with quantity management 
- Persistent cart storage that survives app restarts and terminations
- Checkout flow with integrated wallet balance validation
- Loading states with progress indicators for all async operations
- Error handling with retry options and clear error messages
- Toast notifications for user actions and feedback

## Architecture

Layered Architecture Structure:
- Presentation Layer: SwiftUI Views and ViewModels
- Domain Layer: Business models and repository protocols
- Core Layer: Services, utilities, and navigation

Architecture Patterns:
- MVVM: Model-View-ViewModel for separation of concerns
- Repository Pattern: Abstract data access layer
- Coordinator Pattern: Centralized navigation
- Protocol-Oriented: Dependency injection for testability

State Management:
- Observable macro for reactive state updates
- Generic AsyncLoadingState for consistent loading/error/success states
- Modern async/await throughout the application

## Requirements

Development Requirements:
- Xcode 15.0 or higher (lower versions not tested)
- iOS 17.0 or higher deployment target
- Swift 5.0 language version

My Development Environment:
- Xcode Version 26.1.1
- macOS Tahoe 

Testing Devices:
- Physical Device: iPhone 13 running iOS 18.7.1
- Simulator: iPhone 15 Pro

## Github repository link

https://github.com/uddin-nasir-jp/Mini-Super-Pay.git


## Project Structure

MiniSuperPay/
├── Core/
│   ├── Navigation/          # Coordinator pattern implementation
│   ├── Services/            # Network and storage services
│   └── Utilities/           # Extensions, constants, helpers
├── Domain/
│   ├── Models/              # Data models and entities
│   └── Repositories/        # Data access protocols and implementations
├── Presentation/
│   ├── ProductList/         # Product browsing feature
│   ├── ProductDetail/       # Product detail view
│   ├── Cart/                # Shopping cart feature
│   ├── Checkout/            # Checkout and payment flow
│   └── Shared/              # Reusable UI components
└── Resources/
    ├── Assets.xcassets      # Images, colors, icons
    └── Data/                # Mock JSON data files



Test Coverage:
- Approximately 20% code coverage


## Author

Md Nasir Uddin
GitHub: https://github.com/uddin-nasir-jp

Built with modern Swift and SwiftUI best practices. 
