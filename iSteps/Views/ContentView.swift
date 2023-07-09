//
//  ContentView.swift
//  iSteps
//
//  Created by Данил Белов on 04.07.2023.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    private var healthStore: HealthStore?
    @State private var steps: [Step] = [Step]()
    
    init() {
        healthStore = HealthStore()
    }
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let today = Date()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        guard let firstWeekDay = week?.start else { return }
        guard let lastWeekDay = week?.end else { return }
        
        statisticsCollection.enumerateStatistics(from: firstWeekDay, to: lastWeekDay - 1) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                ActivityView(steps: steps)
                    .tabItem {
                        VStack {
                            Image(systemName: "target")
                            
                            Text("Activity")
                        }
                    }
                
                Fitness_View()
                    .tabItem {
                        VStack {
                            Image(systemName: "figure.run.circle.fill")
                            
                            Text("Fitness+")
                        }
                    }
                
                SharingView()
                    .tabItem {
                        VStack {
                            Image(systemName: "s.circle.fill")
                            
                            Text("Sharing")
                        }
                    }
            }
        }
        .onAppear {
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    if success {
                        healthStore.calculateSteps { statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                                updateUIFromStatistics(statisticsCollection)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

