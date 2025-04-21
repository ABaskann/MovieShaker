//
//  CapsuleItem.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 20.04.2025.
//

import SwiftUI

struct CapsuleItem: View {
    let icon: String
    let text: String
    
    var body: some View {
        VStack(alignment: .center,spacing: 16) {
            Image(systemName: icon).foregroundStyle(.color1)
            Text(text)
        }
        .foregroundStyle(.white)
        .padding(.vertical, 8)
        .padding(.horizontal,8)
        
        .font(.headline.bold())
    }
}
