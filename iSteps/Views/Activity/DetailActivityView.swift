//
//  DetailStepStatisticView.swift
//  iSteps
//
//  Created by Данил Белов on 06.07.2023.
//

import SwiftUI

struct DetailActivityView: View {
    
    var step: Step
    
    @State private var isShareViewPresented = false
    @State private var progress = 0
    
    var calories: Int {
        step.count / 20
    }
    
    var sharedTextDetailed: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            var sharedText =
            """
            🥇 Steps: \(step.count)
            🗓 Date: \(dateFormatter.string(from: Date()))
            ________________\n
            """
            
            sharedText.append(
            """

            🚶 Total calories: \(step.count / 20)
            ________________\n
                        
            Sent with iSteps
            """
            )
            return sharedText        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ActivityRing(progress: CGFloat(progress > 1 ? self.progress : self.progress + 1) + ((progress % 10 == 0) ? 0 : CGFloat.random(in: 0.0...0.9)))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 30)
                
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Move")
                            .font(.system(size: 22, weight: .medium, design: .rounded))
                        
                        Text("\(calories)/250 KCAL")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(Color.mainRed)
                    }
                    
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Steps")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                        
                        Text("\(step.count)")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(Color.lightGray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Distance")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                        
                        Text("\((Double(step.count) * 0.5 / 1000).formatNumber()) KM")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(Color.lightGray)
                    }
                }
                .padding(.top, 20)
                
                Divider()
            }
            .padding()
            .navigationBarTitle("\(step.date, formatter: Date.dateFormatter(string: "E, d MMM YYYY"))", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "calendar")
                        }
                        
                        Button {
                            isShareViewPresented = true
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .sheet(isPresented: $isShareViewPresented) {
                            ShareViewController(activityItems: [sharedTextDetailed])
                                .presentationDetents([.medium, .large])
                                .ignoresSafeArea()
                        }
                    }
                }
            }
            .onAppear {
                progress = step.count - 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring().speed(0.4)) {
                        progress = step.count
                    }
                }
            }
        }
    }
}

struct DetailActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
