//
//  LoadingView.swift
//  FitPlay_TH_Bonan
//
//  Created by IGOR on 28/08/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("aifpth")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 130)
            }
            
            VStack {
                
                Spacer()
                
                ProgressView()
                    .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    LoadingView()
}
