//
//  LottieView.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 21.04.2025.
//


import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var animationName: String
    var onAnimationCompleted: (() -> Void)?

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView(name: animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play { finished in
            if finished {
                DispatchQueue.main.async {
                    onAnimationCompleted?()
                }
            }
        }
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}