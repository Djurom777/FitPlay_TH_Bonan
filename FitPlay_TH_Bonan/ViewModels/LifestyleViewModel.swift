//
//  LifestyleViewModel.swift
//  FitPlay_TH_Bonan
//
//  Created by IGOR on 19/08/2025.
//

import Foundation
import SwiftUI

class LifestyleViewModel: ObservableObject {
    @Published var tips = LifestyleTip.sampleTips
    @Published var expandedTipId: UUID?
    
    func toggleTipExpansion(_ tipId: UUID) {
        withAnimation(.easeInOut(duration: 0.3)) {
            if expandedTipId == tipId {
                expandedTipId = nil
            } else {
                expandedTipId = tipId
            }
        }
    }
    
    func isTipExpanded(_ tipId: UUID) -> Bool {
        return expandedTipId == tipId
    }
}