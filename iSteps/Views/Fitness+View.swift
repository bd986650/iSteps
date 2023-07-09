//
//  Fitness+View.swift
//  iSteps
//
//  Created by Данил Белов on 08.07.2023.
//

import SwiftUI

struct Fitness_View: View {
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                Text("Welcome to Fitness+")
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                
                VStack(alignment: .leading, spacing: 10) {
                    FitnessToolsRow(title: "Workouts for Everyone", description: "Eleven different types from HIIT \nto Yoga.", icon: "figure.run.circle.fill")
                    
                    FitnessToolsRow(title: "Guided Meditations", description: "Practise mindfulness in as \nlittle as five minutes.", icon: "waveform.path.ecg")
                    
                    FitnessToolsRow(title: "Programmes, Collections and More", description: "Find the right workouts and \nmeditations for your goals.", icon: "play.square.stack.fill")
                }
                
                Button {
                    
                } label: {
                    VStack(spacing: 10) {
                        Image(systemName: "person.icloud.fill")
                            .font(.title)
                            .foregroundColor(.accentColor)
                        
                        Text("When you explore the Apple Fitness+ service prior to \nsubscribing, Apple may use your browsing activity in the \nFitness+ tab to improve the service. Once you subscribe, your \nbrowsing and workout data is associated with a random \nidentifier. Your account, subscription status and workouts may \nbe used to send you notifications.")
                            .font(.system(size: 12))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        
                        Text("See how your data is managed...")
                            .font(.system(size: 12))
                    }
                }
                
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: .infinity, height: 50)
                            
                        Text("Continue")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 40)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
    
    @ViewBuilder
    func FitnessToolsRow(title: String, description: String, icon: String) -> some View {
        HStack(alignment: .center, spacing: 5) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.accentColor)
                .padding()
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct Fitness_View_Previews: PreviewProvider {
    static var previews: some View {
        Fitness_View()
    }
}
