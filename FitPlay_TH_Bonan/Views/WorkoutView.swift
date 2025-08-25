//
//  WorkoutView.swift
//  FitPlay_TH_Bonan
//
//  Created by IGOR on 19/08/2025.
//

import SwiftUI

struct WorkoutView: View {
    @StateObject private var viewModel = WorkoutViewModel()
    @State private var showingTimerSettings = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.3), Color.purple.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Timer Section
                        VStack(spacing: 20) {
                            Text("Workout Timer")
                                .font(.title2)
                                .font(.title2.bold())
                                .foregroundColor(.primary)
                            
                            // Timer Display
                            ZStack {
                                Circle()
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                                    .frame(width: 200, height: 200)
                                
                                Circle()
                                    .trim(from: 0, to: viewModel.timeRemaining > 0 ? 
                                          CGFloat(viewModel.timeRemaining) / CGFloat(viewModel.timerDuration) : 0)
                                    .stroke(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.pink, .purple]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                                    )
                                    .frame(width: 200, height: 200)
                                    .rotationEffect(.degrees(-90))
                                    .animation(.easeInOut(duration: 1), value: viewModel.timeRemaining)
                                
                                VStack {
                                    Text(viewModel.formattedTime)
                                        .font(.system(size: 36, weight: .bold, design: .monospaced))
                                        .foregroundColor(.primary)
                                    
                                    Text("\(viewModel.timerDuration / 60):\(String(format: "%02d", viewModel.timerDuration % 60)) total")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            // Timer Controls
                            HStack(spacing: 20) {
                                Button(action: {
                                    if viewModel.isTimerRunning {
                                        viewModel.pauseTimer()
                                    } else {
                                        viewModel.startTimer()
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: viewModel.isTimerRunning ? "pause.fill" : "play.fill")
                                        Text(viewModel.isTimerRunning ? "Pause" : "Start")
                                    }
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 12)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.pink, .purple]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(25)
                                    .shadow(color: .pink.opacity(0.3), radius: 5, x: 0, y: 2)
                                }
                                .buttonStyle(ScaleButtonStyle())
                                
                                Button(action: {
                                    viewModel.resetTimer()
                                }) {
                                    HStack {
                                        Image(systemName: "stop.fill")
                                        Text("Reset")
                                    }
                                    .font(.headline)
                                    .foregroundColor(.pink)
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 12)
                                    .background(Color.white)
                                    .cornerRadius(25)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.pink, lineWidth: 2)
                                    )
                                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                            
                            // Timer Duration Selector
                            Button(action: {
                                showingTimerSettings = true
                            }) {
                                HStack {
                                    Image(systemName: "clock")
                                    Text("Set Duration")
                                }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(20)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                        
                        // Exercises List
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Exercises")
                                .font(.title2.bold())
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                            
                            LazyVStack(spacing: 15) {
                                ForEach(viewModel.exercises) { exercise in
                                    ExerciseCard(exercise: exercise)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Workout")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $showingTimerSettings) {
            TimerSettingsView(viewModel: viewModel)
        }
    }
}

struct ExerciseCard: View {
    let exercise: Exercise
    @State private var isPressed = false
    @State private var showingDetail = false
    
    var body: some View {
        HStack(spacing: 15) {
            // Exercise Icon
            Image(systemName: exercise.icon)
                .font(.system(size: 30))
                .foregroundColor(.pink)
                .frame(width: 50, height: 50)
                .background(Color.pink.opacity(0.1))
                .cornerRadius(25)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(exercise.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    // Difficulty Badge
                    Text(exercise.difficulty)
                        .font(.caption2.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            exercise.difficulty == "Beginner" ? Color.green :
                            exercise.difficulty == "Intermediate" ? Color.orange : Color.red
                        )
                        .cornerRadius(8)
                }
                
                Text(exercise.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    Text(exercise.durationSuggestion)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Text("Tap for details")
                        .font(.caption)
                        .foregroundColor(.pink)
                }
            }
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = false
                }
                showingDetail = true
            }
        }
        .sheet(isPresented: $showingDetail) {
            ExerciseDetailView(exercise: exercise)
        }
    }
}

struct TimerSettingsView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDuration = 60
    
    let durations = [30, 60, 90, 120, 180, 300] // seconds
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Select Timer Duration")
                    .font(.title2)
                    .font(.title2.bold())
                    .padding(.top)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
                    ForEach(durations, id: \.self) { duration in
                        Button(action: {
                            selectedDuration = duration
                        }) {
                            VStack {
                                Text("\(duration / 60):\(String(format: "%02d", duration % 60))")
                                    .font(.title3)
                                    .font(.title2.bold())
                                Text(duration < 60 ? "seconds" : duration == 60 ? "minute" : "minutes")
                                    .font(.caption)
                            }
                            .foregroundColor(selectedDuration == duration ? .white : .pink)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                selectedDuration == duration ?
                                LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing) :
                                LinearGradient(gradient: Gradient(colors: [.clear]), startPoint: .leading, endPoint: .trailing)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.pink, lineWidth: selectedDuration == duration ? 0 : 2)
                            )
                            .cornerRadius(15)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    viewModel.setTimerDuration(selectedDuration)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Set Duration")
                        .font(.headline)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.pink, .purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                        .shadow(color: .pink.opacity(0.3), radius: 5, x: 0, y: 2)
                }
                .buttonStyle(ScaleButtonStyle())
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Timer Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
        .onAppear {
            selectedDuration = viewModel.timerDuration
        }
    }
}

#Preview {
    WorkoutView()
}