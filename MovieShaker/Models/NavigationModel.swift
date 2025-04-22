//
//  NavigationModel.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 15.04.2025.
//


import SwiftUI

class NavigationModel: ObservableObject {
    // Her sekme için ayrı NavigationPath
    @Published var homePath = NavigationPath()
    @Published var shakePath = NavigationPath()
//    @Published var blogPath = NavigationPath()
    @Published var categoryPath = NavigationPath()
    


    // İstediğin sekmede navigate et
    func navigateTo(_ page: Page, in tab: AppTab) {
        switch tab {
        case .home: homePath.append(page)
        case .category: categoryPath.append(page)
//        case .blog: blogPath.append(page)
//        case .search: searchPath.append(page)
        case .shake: break // Shake için navigation yoksa atla
        }
    }

    func navigateBack(in tab: AppTab) {
        switch tab {
        case .home: if !homePath.isEmpty { homePath.removeLast() }
        case .category: if !categoryPath.isEmpty { categoryPath.removeLast() }
//        case .blog: if !blogPath.isEmpty { blogPath.removeLast() }
//        case .search: if !searchPath.isEmpty { searchPath.removeLast() }
        case .shake: break
        }
    }

    func resetPath(in tab: AppTab) {
        switch tab {
        case .home: homePath = NavigationPath()
        case .category: categoryPath = NavigationPath()
//        case .blog: blogPath = NavigationPath()
//        case .search: searchPath = NavigationPath()
        case .shake: break
        }
    }

    func resetAllPaths() {
        homePath = NavigationPath()
        categoryPath = NavigationPath()
        shakePath = NavigationPath()
    }
}

// Tüm ekranları temsil eden enum
enum Page: Hashable {
    case Home
    case Category
    case Shake
    case MovieDetail(Int)
    case MovieList(Int,String)
   
}

// Sekmeleri temsil eden enum
enum AppTab: Hashable {
    case home, shake, category
//    , search, blog
}
