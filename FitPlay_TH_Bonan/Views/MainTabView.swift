//
//  MainTabView.swift
//  FitPlay_TH_Bonan
//
//  Created by IGOR on 19/08/2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            WorkoutView()
                .tabItem {
                    Image(systemName: "figure.strengthtraining.traditional")
                    Text("Workout")
                }
                .tag(0)
            
            LifestyleView()
                .tabItem {
                    Image(systemName: "leaf.fill")
                    Text("Lifestyle")
                }
                .tag(1)
            
            GameView()
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Game")
                }
                .tag(2)
        }
        .accentColor(.pink)
        .onAppear {
            // Customize tab bar appearance
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.systemBackground
            
            // Selected tab color
            appearance.selectionIndicatorTintColor = UIColor.systemPink
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    MainTabView()
}