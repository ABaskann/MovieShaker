//
//  MovieCarouselView.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 16.04.2025.
//

import SwiftUI

struct MovieCarouselView: View {
    @StateObject var viewModel = HomeViewModel()
    let rows = [
        GridItem()
    ]
    var body: some View {
//        VStack(alignment:.leading){
//            HStack{
//                Text("Today Popular Movies")
//                    .foregroundStyle(.white)
//                    .font(.headline)
//                Spacer()
//
//            }
//            Rectangle()
//                .fill(Color.color1)
//                .frame(width:180,height:4)
//        }
//        .padding(.top,16)
//        .padding(.horizontal)
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 16) {
                ForEach(Array(viewModel.movies.enumerated().prefix(10)), id: \.1.id) { index, movie in
                    MovieCardView(movie: movie, index: index + 1)
                    
                   
                        
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.getTopRatedMovies()
        }
    }
}

#Preview {
    MovieCarouselView()
}
