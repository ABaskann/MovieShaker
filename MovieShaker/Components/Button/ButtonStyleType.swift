//
//  ButtonStyleType.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 16.04.2025.
//


//
//  ButtonStyleType.swift
//  AIWrapperBase
//
//  Created by Armağan Başkan on 26.03.2025.
//


import SwiftUI

enum ButtonStyleType {
    case primary, secondary, iconprimary, iconsecondary, custom(bgColor: Color, textColor: Color, border: Color?, icon: String?)
    
    var backgroundColor: Color {
        switch self {
        case .primary: return Color.color1
        case .secondary: return Color.color2
        case .iconprimary: return Color.color2
        case .iconsecondary: return Color.color1
        case .custom(let bgColor, _, _, _): return bgColor
        }
    }
    
    var textColor: Color {
        switch self {
        case .primary: return Color.black
        case .secondary: return Color.white
        case .iconprimary: return Color.white
        case .iconsecondary: return Color.black
        case .custom(_, let textColor, _, _): return textColor
        }
    }
    
    var borderColor: Color? {
        switch self {
        case .primary, .iconprimary, .iconsecondary: return nil
        case .secondary: return Color.black
        case .custom(_, _, let border, _): return border
        }
    }
    
    var iconName: String? {
        switch self {
        case .primary: return nil
        case .secondary: return nil
        case .iconprimary: return "camera.fill"
        case .iconsecondary: return "photo.on.rectangle.angled"
        case .custom(_, _, _, let icon): return icon
        }
    }
}

struct CustomButton: View {
    var title: String
    var style: ButtonStyleType = .primary
    var isLoading: Bool = false
    var isDisabled: Bool = false
    var cornerRadius: CGFloat = 8
    var hapticFeedback: Bool = true
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            if hapticFeedback {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            }
            if !isLoading && !isDisabled {
                action()
            }
        }) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: style.textColor))
                        .frame(height: 20)
                } else {
                    HStack{
                        if let icon = style.iconName {
                            Image(systemName: icon)
                            
                        }
                        Text(title)
                    } .foregroundColor(style.textColor)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                }
            }
            .background(style.backgroundColor.opacity(isDisabled ? 0.5 : 1.0))
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(style.borderColor ?? Color.clear, lineWidth: style.borderColor != nil ? 1 : 0)
            )
            .frame(maxWidth: 360)
        }
        .disabled(isDisabled || isLoading)
    }
}
#Preview {
    VStack{
        CustomButton(title: "Button", style: .primary, isLoading: false, isDisabled: false, cornerRadius: 8, hapticFeedback: true, action: {})
        CustomButton(title: "Sign In Google", style: .secondary, isLoading: false, isDisabled: false, cornerRadius: 8, hapticFeedback: true, action: {})
        CustomButton(title: "Take a Photo", style: .iconprimary, isLoading: false, isDisabled: false, cornerRadius: 12, hapticFeedback: true, action: {})
        CustomButton(title: "Open Galery", style: .iconsecondary, isLoading: false, isDisabled: false, cornerRadius: 12, hapticFeedback: true, action: {})
    }
    
}
