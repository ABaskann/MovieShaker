//
//  WelcomeView.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 16.04.2025.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack{
                Color.color1.ignoresSafeArea()
                Color.color2
                .mask(DiagonalShape())
                .ignoresSafeArea()
            
              
            VStack{
                Text("Movie Shaker")
                    .foregroundStyle(.red)
                Spacer()
                Text("Tap to start")
                    .foregroundStyle(.red)
                    
            }
            
        }
        
    }
    
    struct DiagonalShape: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            // Üst soldan başla, sağ üst köşeye git, sol alt köşeye git
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.maxY))
            path.closeSubpath()
            return path
        }
    }
}

#Preview {
    WelcomeView()
}
