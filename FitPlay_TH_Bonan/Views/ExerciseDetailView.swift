//
//  ExerciseDetailView.swift
//  FitPlay_TH_Bonan
//
//  Created by IGOR on 19/08/2025.
//

import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise
    @StateObject private var timerViewModel = WorkoutViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showingTimerSettings = false
    
    private var difficultyColor: Color {
        switch exercise.difficulty {
        case "Beginner":
            return .green
        case "Intermediate":
            return .orange
        case "Advanced":
            return .red
        default:
            return .blue
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Header Section
                    VStack(spacing: 20) {
                        // Exercise Icon
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.pink, .purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: exercise.icon)
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing: 10) {
                            Text(exercise.title)
                                .font(.largeTitle.bold())
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                            
                            // Difficulty Badge
                            Text(exercise.difficulty.uppercased())
                                .font(.caption.bold())
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(difficultyColor)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    // Timer Section
                    VStack(spacing: 20) {
                        Text("Exercise Timer")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                        
                        // Timer Display
                        ZStack {
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 6)
                                .frame(width: 150, height: 150)
                            
                            Circle()
                                .trim(from: 0, to: timerViewModel.timeRemaining > 0 ? 
                                      CGFloat(timerViewModel.timeRemaining) / CGFloat(timerViewModel.timerDuration) : 0)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.pink, .purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    style: StrokeStyle(lineWidth: 6, lineCap: .round)
                                )
                                .frame(width: 150, height: 150)
                                .rotationEffect(.degrees(-90))
                                .animation(.easeInOut(duration: 1), value: timerViewModel.timeRemaining)
                            
                            VStack {
                                Text(timerViewModel.formattedTime)
                                    .font(.system(size: 24, weight: .bold, design: .monospaced))
                                    .foregroundColor(.primary)
                                
                                Text(exercise.durationSuggestion)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        
                        // Timer Controls
                        HStack(spacing: 15) {
                            Button(action: {
                                if timerViewModel.isTimerRunning {
                                    timerViewModel.pauseTimer()
                                } else {
                                    timerViewModel.startTimer()
                                }
                            }) {
                                HStack {
                                    Image(systemName: timerViewModel.isTimerRunning ? "pause.fill" : "play.fill")
                                    Text(timerViewModel.isTimerRunning ? "Pause" : "Start")
                                }
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.pink, .purple]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(20)
                            }
                            .buttonStyle(ScaleButtonStyle())
                            
                            Button(action: {
                                timerViewModel.resetTimer()
                            }) {
                                HStack {
                                    Image(systemName: "stop.fill")
                                    Text("Reset")
                                }
                                .font(.subheadline)
                                .foregroundColor(.pink)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.white)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.pink, lineWidth: 2)
                                )
                            }
                            .buttonStyle(ScaleButtonStyle())
                            
                            Button(action: {
                                showingTimerSettings = true
                            }) {
                                Image(systemName: "clock")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .padding(10)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(15)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    // Instructions Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Instructions")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                        
                        Text(exercise.detailedInstructions)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(6)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    // Tips Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Tips")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                        
                        LazyVStack(alignment: .leading, spacing: 8) {
                            ForEach(exercise.tips, id: \.self) { tip in
                                HStack(alignment: .top, spacing: 10) {
                                    Image(systemName: "lightbulb.fill")
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 14))
                                        .padding(.top, 2)
                                    
                                    Text(tip)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                        .lineSpacing(4)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    // Muscle Groups Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Target Muscles")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                            ForEach(exercise.muscleGroups, id: \.self) { muscle in
                                Text(muscle)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.blue, .cyan]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(15)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    // Benefits Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Benefits")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                        
                        LazyVStack(alignment: .leading, spacing: 8) {
                            ForEach(exercise.benefits, id: \.self) { benefit in
                                HStack(alignment: .top, spacing: 10) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                        .font(.system(size: 14))
                                        .padding(.top, 2)
                                    
                                    Text(benefit)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                        .lineSpacing(4)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                }
                .padding()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.3), Color.purple.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .navigationTitle("Exercise Details")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .sheet(isPresented: $showingTimerSettings) {
            TimerSettingsView(viewModel: timerViewModel)
        }
    }
}

#Preview {
    ExerciseDetailView(exercise: Exercise.sampleExercises[0])
}