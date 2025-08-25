//
//  LifestyleTip.swift
//  FitPlay_TH_Bonan
//
//  Created by IGOR on 19/08/2025.
//

import Foundation

struct LifestyleTip: Identifiable, Codable {
    let id = UUID()
    let title: String
    let shortDescription: String
    let detailedDescription: String
    let icon: String
    let category: String
    
    static let sampleTips = [
        LifestyleTip(
            title: "Healthy Eating",
            shortDescription: "Fuel your body with nutritious foods",
            detailedDescription: "Focus on whole foods like fruits, vegetables, lean proteins, and whole grains. Aim for 5-7 servings of fruits and vegetables daily. Stay hydrated with 8 glasses of water. Limit processed foods and added sugars for optimal health and energy.",
            icon: "leaf.fill",
            category: "Nutrition"
        ),
        LifestyleTip(
            title: "Sleep Schedule",
            shortDescription: "Get 7-9 hours of quality sleep nightly",
            detailedDescription: "Maintain a consistent sleep schedule by going to bed and waking up at the same time daily. Create a relaxing bedtime routine, avoid screens 1 hour before bed, and keep your bedroom cool, dark, and quiet for optimal rest and recovery.",
            icon: "moon.fill",
            category: "Rest"
        ),
        LifestyleTip(
            title: "Daily Hydration",
            shortDescription: "Drink plenty of water throughout the day",
            detailedDescription: "Aim for 8-10 glasses of water daily. Start your morning with a glass of water, carry a water bottle, and drink before you feel thirsty. Proper hydration improves energy, brain function, and helps maintain healthy skin.",
            icon: "drop.fill",
            category: "Hydration"
        ),
        LifestyleTip(
            title: "Daily Routine",
            shortDescription: "Structure your day for success",
            detailedDescription: "Create a morning routine that sets a positive tone for your day. Include time for exercise, healthy meals, work, and relaxation. Having a structured routine reduces stress, improves productivity, and helps maintain work-life balance.",
            icon: "clock.fill",
            category: "Lifestyle"
        )
    ]
}