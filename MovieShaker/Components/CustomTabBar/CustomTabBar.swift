//
//  CustomTabBar.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 15.04.2025.
//


//
//  Tab.swift
//  AIWrapperBase
//
//  Created by Armağan Başkan on 13.04.2025.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack {
            tabButton(icon: "house.fill", label: "Home", tab: .home)
            //scanButton
            tabButton(icon: "iphone.gen1.radiowaves.left.and.right", label: "Shake", tab: .shake)
            
            tabButton(icon: "square.grid.3x3", label: "Categories", tab: .category)
        }
        .padding(.top,16)
        .padding(.bottom,23)
        .background(
            Color.background
                .shadow(radius: 8)
                .overlay(
                    Rectangle()
                        .fill(Color.color1)
                        .frame(height: 4)
                        .frame(maxHeight: .infinity, alignment: .top)
                )
        )
    }

    func tabButton(icon: String, label: String, tab: AppTab) -> some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .regular))
            Text(label)
                .font(.caption2)
        }
        .foregroundColor(selectedTab == tab ? .color1 : .gray)
        .frame(maxWidth: .infinity)
        .onTapGesture {
            selectedTab = tab
        }
    }

    var scanButton: some View {
        Button(action: {
            selectedTab = .shake
        }) {
            ZStack {
                Circle()
                    .fill(Color.color1)
                    .frame(width: 54, height: 54)

                Image(systemName: "iphone.gen1.radiowaves.left.and.right")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .bold))
            }
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.home))
}

