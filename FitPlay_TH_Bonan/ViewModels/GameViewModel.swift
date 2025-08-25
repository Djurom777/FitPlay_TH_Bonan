//
//  GameViewModel.swift
//  FitPlay_TH_Bonan
//
//  Created by IGOR on 19/08/2025.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var gameState = GameState()
    @Published var screenSize: CGSize = .zero
    
    private var gameTimer: Timer?
    private var fruitSpawnTimer: Timer?
    
    func startGame() {
        gameState.isPlaying = true
        gameState.gameOver = false
        gameState.score = 0
        gameState.fruits = []
        
        // Main game loop - update fruit positions
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { _ in
            DispatchQueue.main.async {
                self.updateGame()
            }
        }
        
        // Spawn new fruits
        fruitSpawnTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            DispatchQueue.main.async {
                self.spawnFruit()
            }
        }
    }
    
    func stopGame() {
        gameState.isPlaying = false
        gameState.gameOver = true
        gameTimer?.invalidate()
        fruitSpawnTimer?.invalidate()
        gameTimer = nil
        fruitSpawnTimer = nil
    }
    
    func restartGame() {
        stopGame()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.startGame()
        }
    }
    
    private func updateGame() {
        for i in gameState.fruits.indices {
            gameState.fruits[i].position.y += gameState.fruits[i].velocity
        }
        
        // Remove fruits that fell off screen
        gameState.fruits.removeAll { fruit in
            fruit.position.y > screenSize.height + 100
        }
    }
    
    private func spawnFruit() {
        guard gameState.isPlaying else { return }
        let newFruit = Fruit.random(screenWidth: screenSize.width)
        gameState.fruits.append(newFruit)
    }
    
    func catchFruit(_ fruit: Fruit) {
        withAnimation(.easeOut(duration: 0.2)) {
            gameState.score += fruit.points
            gameState.fruits.removeAll { $0.id == fruit.id }
        }
    }
    
    func setScreenSize(_ size: CGSize) {
        screenSize = size
    }
}