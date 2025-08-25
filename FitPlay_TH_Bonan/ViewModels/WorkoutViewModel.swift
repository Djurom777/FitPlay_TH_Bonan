//
//  WorkoutViewModel.swift
//  FitPlay_TH_Bonan
//
//  Created by IGOR on 19/08/2025.
//

import Foundation
import SwiftUI

class WorkoutViewModel: ObservableObject {
    @Published var exercises = Exercise.sampleExercises
    @Published var timeRemaining: Int = 0
    @Published var isTimerRunning = false
    @Published var timerDuration: Int = 60 // Default 1 minute
    
    private var timer: Timer?
    
    func startTimer() {
        guard !isTimerRunning else { return }
        
        if timeRemaining == 0 {
            timeRemaining = timerDuration
        }
        
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            DispatchQueue.main.async {
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.stopTimer()
                }
            }
        }
    }
    
    func pauseTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        timeRemaining = 0
    }
    
    func setTimerDuration(_ duration: Int) {
        timerDuration = duration
        if !isTimerRunning {
            timeRemaining = 0
        }
    }
    
    var formattedTime: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}