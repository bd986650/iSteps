//
//  StatisticView.swift
//  iSteps
//
//  Created by Данил Белов on 06.07.2023.
//

import SwiftUI
import HealthKit

struct ActivityView: View {
    
    var steps: [Step]
    
    @State private var isShareViewPresented = false
    
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0,+)
    }
    
    var totalCalories: Int {
        (steps.map { $0.count }.reduce(0,+)) / 20
    }
    
    var totalDistance: Double {
        Double(steps.map { $0.count }.reduce(0,+)) / 2000.0
    }
    
    var sharedTextDetailed: String {
        get {            
            var sharedText =
            """
            🚶 Total Steps: \(totalSteps)
            🏃 Distance: \(totalDistance)
            🥇 Calories: \(totalCalories)
            """
            
            sharedText.append(
            """
            \n________________\n
            Sent with iSteps❤️
            """
            )
            return sharedText        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        ActivityRectangle(iconString: "figure.step.training", description: "Steps / Week", value: "\(totalSteps)", color: Color.mainRed)
                        
                        ActivityRectangle(iconString: "flame", description: "Calories / Week", value: "\(totalCalories)", color: Color.mainRed)
                    }
                    .frame(height: 150)
                    
                    GraphView(steps: steps)
                    
                    HStack(spacing: 20) {
                        ActivityRectangle(iconString: "figure.walk", description: "KM / Week", value: "\(totalDistance)", color: Color.mainRed)
                        
                        ActivityRectangle(iconString: "drop", description: "Water (Cup)", value: "7", color: Color.mainRed)
                    }
                    .frame(height: 150)
                }
                .navigationTitle("Fitness")
                .padding(5)
                .padding(.horizontal, 10)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("\(Date(), formatter: Date.dateFormatter(string: "EEEE, d MMM"))")
                            .font(.system(size: 16, weight: .bold, design: .rounded).uppercaseSmallCaps())
                            .opacity(0.7)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShareViewPresented = true
                        } label: {
                            Image(systemName: "shareplay")
                        }
                        .sheet(isPresented: $isShareViewPresented) {
                            ShareViewController(activityItems: [sharedTextDetailed])
                        }
                    }
                }
            }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
