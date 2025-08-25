//
//  GameModels.swift
//  FitPlay_TH_Bonan
//
//  Created by IGOR on 19/08/2025.
//

import Foundation
import SwiftUI

struct Fruit: Identifiable {
    let id = UUID()
    let emoji: String
    let points: Int
    var position: CGPoint
    var velocity: CGFloat
    
    static let fruitTypes = ["🍎", "🍌", "🍇", "🍒", "🍍"]
    
    static func random(screenWidth: CGFloat) -> Fruit {
        let emoji = fruitTypes.randomElement() ?? "🍎"
        let points = Int.random(in: 10...50)
        let x = CGFloat.random(in: 50...(screenWidth - 50))
        
        return Fruit(
            emoji: emoji,
            points: points,
            position: CGPoint(x: x, y: -50),
            velocity: CGFloat.random(in: 2...5)
        )
    }
}

struct GameState {
    var score: Int = 0
    var isPlaying: Bool = false
    var gameOver: Bool = false
    var fruits: [Fruit] = []
}