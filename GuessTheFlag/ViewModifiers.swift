//
//  ViewModifiers.swift
//  GuessTheFlag
//
//  Created by PhyoWai Aung on 8/28/24.
//
import SwiftUI

// Opacity Modifier
struct FlagOpacityModifier: ViewModifier {
    let selectedButton: Int?
    let number: Int
    
    func body(content: Content) -> some View {
        content
            .opacity(selectedButton == nil || selectedButton == number ? 1 : 0.25)
    }
}

//FlagRotationModifier
struct FlagRotationModifier: ViewModifier {
    let animationAmount: Double
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(animationAmount),
                axis: (x: 0, y: 1, z: 0)
            )
    }
}

// FlagScaleModifier
struct FlagScaleModifier: ViewModifier {
    let selectedButton: Int?
    let number: Int
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(selectedButton == nil || selectedButton == number ? 1 : 0.5)
    }
}

//FlagFlipModifier
struct FlagFlipModifier: ViewModifier {
    let selectedButton: Int?
    let number: Int
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(selectedButton == nil || selectedButton == number ? 0 : 180),
                axis: (x: 1, y: 0, z: 0)
            )
    }
}

