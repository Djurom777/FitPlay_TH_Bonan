//
//  GameView.swift
//  FitPlay_TH_Bonan
//
//  Created by IGOR on 19/08/2025.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    // Background gradient
                    LinearGradient(
                        gradient: Gradient(colors: [Color.orange.opacity(0.4), Color.yellow.opacity(0.4)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    
                    if !viewModel.gameState.isPlaying && !viewModel.gameState.gameOver {
                        // Start screen
                        VStack(spacing: 30) {
                            Spacer()
                            
                            VStack(spacing: 20) {
                                Image(systemName: "gamecontroller.fill")
                                    .font(.system(size: 80))
                                    .foregroundColor(.orange)
                                    .scaleEffect(1.2)
                                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: viewModel.gameState.isPlaying)
                                
                                Text("Catch the Fruits")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.primary)
                                
                                Text("Tap falling fruits to score points!")
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                                
                                // Fruit emojis preview
                                HStack(spacing: 10) {
                                    ForEach(Fruit.fruitTypes, id: \.self) { fruit in
                                        Text(fruit)
                                            .font(.system(size: 30))
                                            .scaleEffect(0.8)
                                            .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true).delay(Double.random(in: 0...1)), value: viewModel.gameState.isPlaying)
                                    }
                                }
                                .padding()
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.startGame()
                            }) {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text("Start Game")
                                }
                                .font(.title2.bold())
                                .foregroundColor(.white)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 15)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.orange, .yellow]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(25)
                                .shadow(color: .orange.opacity(0.3), radius: 10, x: 0, y: 5)
                            }
                            .buttonStyle(ScaleButtonStyle())
                            
                            Spacer()
                        }
                        .padding()
                    } else if viewModel.gameState.gameOver {
                        // Game over screen
                        VStack(spacing: 30) {
                            Spacer()
                            
                            VStack(spacing: 20) {
                                Image(systemName: "trophy.fill")
                                    .font(.system(size: 80))
                                    .foregroundColor(.yellow)
                                    .scaleEffect(1.1)
                                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: viewModel.gameState.gameOver)
                                
                                Text("Game Over!")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.primary)
                                
                                Text("Final Score")
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                                
                                Text("\(viewModel.gameState.score)")
                                    .font(.system(size: 60, weight: .bold, design: .rounded))
                                    .foregroundColor(.orange)
                                    .padding()
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(20)
                                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 20) {
                                Button(action: {
                                    viewModel.restartGame()
                                }) {
                                    HStack {
                                        Image(systemName: "arrow.clockwise")
                                        Text("Play Again")
                                    }
                                    .font(.headline)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 12)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.orange, .yellow]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(25)
                                    .shadow(color: .orange.opacity(0.3), radius: 5, x: 0, y: 2)
                                }
                                .buttonStyle(ScaleButtonStyle())
                                
                                Button(action: {
                                    viewModel.gameState = GameState()
                                }) {
                                    HStack {
                                        Image(systemName: "house.fill")
                                        Text("Home")
                                    }
                                    .font(.headline)
                                    .font(.headline)
                                    .foregroundColor(.orange)
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 12)
                                    .background(Color.white)
                                    .cornerRadius(25)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.orange, lineWidth: 2)
                                    )
                                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                            
                            Spacer()
                        }
                        .padding()
                    } else {
                        // Game playing screen
                        ZStack {
                            // Score display
                            VStack {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Score")
                                            .font(.headline)
                                            .foregroundColor(.secondary)
                                        Text("\(viewModel.gameState.score)")
                                            .font(.system(size: 36, weight: .bold, design: .rounded))
                                            .foregroundColor(.orange)
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        viewModel.stopGame()
                                    }) {
                                        Image(systemName: "stop.fill")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                            .padding(12)
                                            .background(Color.red)
                                            .cornerRadius(20)
                                            .shadow(color: .red.opacity(0.3), radius: 5, x: 0, y: 2)
                                    }
                                    .buttonStyle(ScaleButtonStyle())
                                }
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(15)
                                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                                
                                Spacer()
                            }
                            
                            // Falling fruits
                            ForEach(viewModel.gameState.fruits) { fruit in
                                Button(action: {
                                    viewModel.catchFruit(fruit)
                                }) {
                                    Text(fruit.emoji)
                                        .font(.system(size: 40))
                                        .scaleEffect(1.2)
                                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                                }
                                .position(fruit.position)
                                .transition(.scale.combined(with: .opacity))
                                .animation(.easeOut(duration: 0.2), value: fruit.position)
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.setScreenSize(geometry.size)
                }
                .onChange(of: geometry.size) { newSize in
                    viewModel.setScreenSize(newSize)
                }
            }
            .navigationTitle("Game")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(viewModel.gameState.isPlaying)
        }
    }
}

#Preview {
    GameView()
}