//
//  Exercise.swift
//  FitPlay_TH_Bonan
//
//  Created by IGOR on 19/08/2025.
//

import Foundation

struct Exercise: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    let durationSuggestion: String
    let icon: String
    let detailedInstructions: String
    let tips: [String]
    let difficulty: String
    let muscleGroups: [String]
    let benefits: [String]
    
    static let sampleExercises = [
        Exercise(
            title: "Squats",
            description: "Stand with feet shoulder-width apart, lower your body as if sitting back into a chair, then return to standing.",
            durationSuggestion: "3 sets of 15 reps",
            icon: "figure.strengthtraining.traditional",
            detailedInstructions: "1. Stand with your feet shoulder-width apart, toes slightly turned out\n2. Keep your chest up and core engaged\n3. Lower your body by bending at the hips and knees\n4. Go down until your thighs are parallel to the floor\n5. Push through your heels to return to starting position\n6. Keep your knees in line with your toes throughout the movement",
            tips: [
                "Keep your weight on your heels",
                "Don't let your knees cave inward",
                "Breathe in on the way down, out on the way up",
                "Start with bodyweight before adding resistance"
            ],
            difficulty: "Beginner",
            muscleGroups: ["Quadriceps", "Glutes", "Hamstrings", "Core"],
            benefits: [
                "Builds lower body strength",
                "Improves functional movement",
                "Burns calories effectively",
                "No equipment needed"
            ]
        ),
        Exercise(
            title: "Push-ups",
            description: "Start in plank position, lower your chest to the ground, then push back up to starting position.",
            durationSuggestion: "3 sets of 10 reps",
            icon: "figure.strengthtraining.functional",
            detailedInstructions: "1. Start in a plank position with hands slightly wider than shoulders\n2. Keep your body in a straight line from head to heels\n3. Lower your chest toward the ground by bending your elbows\n4. Keep your elbows at about 45-degree angle to your body\n5. Push back up to starting position\n6. Maintain tight core throughout the movement",
            tips: [
                "Keep your body straight - no sagging hips",
                "Look down to keep neck neutral",
                "Start on knees if full push-ups are too difficult",
                "Focus on controlled movement, not speed"
            ],
            difficulty: "Intermediate",
            muscleGroups: ["Chest", "Shoulders", "Triceps", "Core"],
            benefits: [
                "Builds upper body strength",
                "Improves core stability",
                "Can be done anywhere",
                "Multiple variations available"
            ]
        ),
        Exercise(
            title: "Plank",
            description: "Hold a push-up position with your body in a straight line from head to heels.",
            durationSuggestion: "Hold for 30-60 seconds",
            icon: "figure.core.training",
            detailedInstructions: "1. Start in a push-up position\n2. Lower down to your forearms, keeping elbows under shoulders\n3. Keep your body in a straight line from head to heels\n4. Engage your core and glutes\n5. Breathe normally while holding the position\n6. Avoid letting your hips sag or pike up",
            tips: [
                "Imagine pulling your belly button to your spine",
                "Keep your head in neutral position",
                "Start with shorter holds and build up",
                "Focus on quality over duration"
            ],
            difficulty: "Beginner",
            muscleGroups: ["Core", "Shoulders", "Glutes"],
            benefits: [
                "Builds core strength",
                "Improves posture",
                "Reduces back pain risk",
                "Enhances stability"
            ]
        ),
        Exercise(
            title: "Running in Place",
            description: "Lift your knees high while running in place, pumping your arms for momentum.",
            durationSuggestion: "2-3 minutes",
            icon: "figure.run",
            detailedInstructions: "1. Stand with feet hip-width apart\n2. Start by lifting one knee up toward your chest\n3. Quickly switch to lift the other knee\n4. Pump your arms naturally as you would when running\n5. Land softly on the balls of your feet\n6. Maintain an upright posture throughout",
            tips: [
                "Lift knees as high as comfortable",
                "Stay light on your feet",
                "Keep your core engaged",
                "Increase intensity by lifting knees higher"
            ],
            difficulty: "Beginner",
            muscleGroups: ["Legs", "Glutes", "Core", "Cardiovascular"],
            benefits: [
                "Improves cardiovascular fitness",
                "Burns calories quickly",
                "Requires no equipment or space",
                "Great warm-up exercise"
            ]
        )
    ]
}