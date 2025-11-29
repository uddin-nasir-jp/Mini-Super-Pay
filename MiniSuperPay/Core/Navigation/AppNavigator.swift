//
//  AppNavigator.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import SwiftUI

@Observable
final class AppNavigator {
    var navPath = NavigationPath()
    var presentedSheet: AppRoute?
    var presentedFullScreenCover: AppRoute?
    
    /// Navigate to specific view
    func navigateTo(_ route: AppRoute) {
        navPath.append(route)
    }
    
    /// Navigate to immediate back view from current view
    func navigateToBack() {
        guard !navPath.isEmpty else { return }
        navPath.removeLast()
    }
    
    /// Navigate to root view from current view
    func navigateToRootView() {
        navPath = NavigationPath()
    }
    
    /// Present/Show sheet/modal view
    func showSheet(_ route: AppRoute) {
        presentedSheet = route
    }
    
    /// Present/Show full screen sheet/modal view
    func showFullScreen(_ route: AppRoute) {
        presentedFullScreenCover = route
    }
    
    /// Dismiss sheet/modal view
    func closeModal() {
        presentedSheet = nil
        presentedFullScreenCover = nil
    }
}
