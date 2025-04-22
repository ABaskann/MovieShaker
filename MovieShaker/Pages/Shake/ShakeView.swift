//
//  ShakeView.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 15.04.2025.
//

import SwiftUI
import UIKit

struct ShakeView: View {
    @StateObject var viewModel = ShakeViewModel()
    @State var situation:Situation = .shake
    enum Situation{
        case shake
        case result
    }
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            switch situation {
            case .shake:
                VStack(spacing:32){
                    Spacer()
                    LottieView(animationName: "Shake")
                        .frame(width: 250,height: 250)
                        .background(
                            Circle().frame(width: 250, height: 250).foregroundColor(.color1)
                        )
                    Text("Shake to discover new movies")
                        .font(.title2.italic())
                        .foregroundStyle(.color1)
                    Spacer()
                    
                }
            case .result:
                if(viewModel.movie.indices.contains(viewModel.randomMovieNumber)) {
                    let movie = viewModel.movie[viewModel.randomMovieNumber]
                    MovieDetailView(movieId: movie.id)
                    
                }
                
            }
               
        }
        .onAppear {
                  NotificationCenter.default.addObserver(forName: .deviceDidShakeNotification, object: nil, queue: .main) { _ in
                      viewModel.getRandomMovie()
                      situation = .result
                  }
              }
              .onDisappear {
                  NotificationCenter.default.removeObserver(self, name: .deviceDidShakeNotification, object: nil)
              }
    }
}

extension UIWindow {
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: .deviceDidShakeNotification, object: nil)
        }
    }
}

extension Notification.Name {
    static let deviceDidShakeNotification = Notification.Name("deviceDidShakeNotification")
}
#Preview {
    ShakeView()
}
