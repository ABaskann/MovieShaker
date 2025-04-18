//
//  ContentView.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 15.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navModel = NavigationModel()
    @State private var selectedTab: AppTab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                ZStack {
                    switch selectedTab {
                    case .home:
                        NavigationStack(path: $navModel.homePath) {
                            HomeView()
                                .environmentObject(navModel)
                                .navigationDestination(for: Page.self) { destinationView(for: $0) }
                        }
                    case .shake:
                        ShakeView()
                    case .category:
                        NavigationStack(path: $navModel.categoryPath) {
                            CategoryView()
                                .environmentObject(navModel)
                                .navigationDestination(for: Page.self) { destinationView(for: $0) }
                            
                        }
                   
                    }
                }
                .frame(maxHeight: .infinity)

                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    @ViewBuilder
    func destinationView(for page: Page) -> some View {
        switch page {
       
        case .Home: HomeView()
        case .Shake: ShakeView()
        case .Category: CategoryView()
        case .MovieDetail(let id): MovieDetailView(movieId: id)
        }
    }
}

#Preview {
    ContentView()
}
