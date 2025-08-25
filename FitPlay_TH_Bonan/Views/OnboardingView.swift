//
//  OnboardingView.swift
//  FitPlay_TH_Bonan
//
//  Created by IGOR on 19/08/2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var showMainApp = false
    
    let onboardingPages = [
        OnboardingPage(
            title: "Welcome to FitPlay",
            subtitle: "Your fitness journey starts here",
            description: "Transform your health with fun workouts, lifestyle tips, and engaging games all in one app!",
            icon: "figure.strengthtraining.traditional",
            gradient: [Color.pink, Color.purple]
        ),
        OnboardingPage(
            title: "Effective Workouts",
            subtitle: "Get fit with guided exercises",
            description: "Follow our expertly designed workout routines with built-in timers and progress tracking.",
            icon: "timer",
            gradient: [Color.blue, Color.cyan]
        ),
        OnboardingPage(
            title: "Healthy Lifestyle",
            subtitle: "Tips for better living",
            description: "Discover practical advice for nutrition, sleep, hydration, and daily routines to optimize your health.",
            icon: "leaf.fill",
            gradient: [Color.green, Color.mint]
        ),
        OnboardingPage(
            title: "Fun Mini-Games",
            subtitle: "Play while you learn",
            description: "Enjoy our Catch the Fruits game and earn points while reinforcing healthy habits!",
            icon: "gamecontroller.fill",
            gradient: [Color.orange, Color.yellow]
        )
    ]
    
    var body: some View {
        if showMainApp {
            MainTabView()
        } else {
            GeometryReader { geometry in
                ZStack {
                    // Background gradient
                    LinearGradient(
                        gradient: Gradient(colors: onboardingPages[currentPage].gradient),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    
                    VStack(spacing: 40) {
                        Spacer()
                        
                        // Icon with animation
                        Image(systemName: onboardingPages[currentPage].icon)
                            .font(.system(size: 80, weight: .light))
                            .foregroundColor(.white)
                            .scaleEffect(currentPage == 0 ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.8), value: currentPage)
                        
                        VStack(spacing: 20) {
                            // Title with slide animation
                            Text(onboardingPages[currentPage].title)
                                .font(.largeTitle)
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing).combined(with: .opacity),
                                    removal: .move(edge: .leading).combined(with: .opacity)
                                ))
                            
                            // Subtitle with fade animation
                            Text(onboardingPages[currentPage].subtitle)
                                .font(.title2)
                                .font(.title2.weight(.medium))
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .transition(.opacity)
                            
                            // Description with scale animation
                            Text(onboardingPages[currentPage].description)
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                                .scaleEffect(0.95)
                                .animation(.easeInOut(duration: 0.6).delay(0.2), value: currentPage)
                        }
                        .animation(.easeInOut(duration: 0.6), value: currentPage)
                        
                        Spacer()
                        
                        // Page indicator
                        HStack(spacing: 12) {
                            ForEach(0..<onboardingPages.count, id: \.self) { index in
                                Circle()
                                    .fill(index == currentPage ? Color.white : Color.white.opacity(0.4))
                                    .frame(width: index == currentPage ? 12 : 8, height: index == currentPage ? 12 : 8)
                                    .animation(.easeInOut(duration: 0.3), value: currentPage)
                            }
                        }
                        .padding(.bottom, 30)
                        
                        // Navigation buttons
                        HStack(spacing: 20) {
                            if currentPage > 0 {
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        currentPage -= 1
                                    }
                                }) {
                                    Text("Back")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 30)
                                        .padding(.vertical, 15)
                                        .background(
                                            RoundedRectangle(cornerRadius: 25)
                                                .fill(Color.white.opacity(0.2))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 25)
                                                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                                )
                                        )
                                }
                                .transition(.move(edge: .leading).combined(with: .opacity))
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                if currentPage < onboardingPages.count - 1 {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        currentPage += 1
                                    }
                                } else {
                                    withAnimation(.easeInOut(duration: 0.8)) {
                                        showMainApp = true
                                    }
                                }
                            }) {
                                Text(currentPage == onboardingPages.count - 1 ? "Get Started" : "Next")
                                    .font(.headline)
                                                                            .font(.headline)
                                    .foregroundColor(onboardingPages[currentPage].gradient[0])
                                    .padding(.horizontal, 40)
                                    .padding(.vertical, 15)
                                    .background(
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(Color.white)
                                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                                    )
                                    .scaleEffect(currentPage == onboardingPages.count - 1 ? 1.1 : 1.0)
                                    .animation(.easeInOut(duration: 0.3), value: currentPage)
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 50)
                    }
                }
            }
        }
    }
}

struct OnboardingPage {
    let title: String
    let subtitle: String
    let description: String
    let icon: String
    let gradient: [Color]
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    OnboardingView()
}