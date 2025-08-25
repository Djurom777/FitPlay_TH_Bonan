//
//  LifestyleView.swift
//  FitPlay_TH_Bonan
//
//  Created by IGOR on 19/08/2025.
//

import SwiftUI

struct LifestyleView: View {
    @StateObject private var viewModel = LifestyleViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.3), Color.mint.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        VStack(spacing: 10) {
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.green)
                                .padding(.top)
                            
                            Text("Healthy Lifestyle Tips")
                                .font(.title2)
                                .font(.title2.bold())
                                .foregroundColor(.primary)
                            
                            Text("Tap any card to learn more")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                        
                        // Tips Cards
                        LazyVStack(spacing: 15) {
                            ForEach(viewModel.tips) { tip in
                                LifestyleTipCard(
                                    tip: tip,
                                    isExpanded: viewModel.isTipExpanded(tip.id),
                                    onTap: {
                                        viewModel.toggleTipExpansion(tip.id)
                                    }
                                )
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Lifestyle")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct LifestyleTipCard: View {
    let tip: LifestyleTip
    let isExpanded: Bool
    let onTap: () -> Void
    
    private var categoryColor: Color {
        switch tip.category {
        case "Nutrition":
            return .orange
        case "Rest":
            return .purple
        case "Hydration":
            return .blue
        case "Lifestyle":
            return .green
        default:
            return .gray
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Main card content
            HStack(spacing: 15) {
                // Icon
                ZStack {
                    Circle()
                        .fill(categoryColor.opacity(0.2))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: tip.icon)
                        .font(.system(size: 25))
                        .foregroundColor(categoryColor)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    // Category badge
                    Text(tip.category.uppercased())
                        .font(.caption2.bold())
                        .foregroundColor(categoryColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(categoryColor.opacity(0.2))
                        .cornerRadius(8)
                    
                    Text(tip.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(tip.shortDescription)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                // Expand/collapse indicator
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                    .rotationEffect(.degrees(isExpanded ? 0 : 0))
                    .animation(.easeInOut(duration: 0.3), value: isExpanded)
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(15)
            
            // Expanded content
            if isExpanded {
                VStack(alignment: .leading, spacing: 15) {
                    Divider()
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Detailed Information")
                            .font(.subheadline)
                            .font(.headline)
                            .foregroundColor(categoryColor)
                        
                        Text(tip.detailedDescription)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                .transition(.asymmetric(
                    insertion: .move(edge: .top).combined(with: .opacity),
                    removal: .move(edge: .top).combined(with: .opacity)
                ))
            }
        }
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
        .scaleEffect(isExpanded ? 1.02 : 1.0)
        .animation(.easeInOut(duration: 0.3), value: isExpanded)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                onTap()
            }
        }
    }
}

#Preview {
    LifestyleView()
}