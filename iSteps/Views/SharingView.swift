//
//  SharingView.swift
//  iSteps
//
//  Created by Данил Белов on 09.07.2023.
//

import SwiftUI

struct SharingView: View {
    var body: some View {
        NavigationStack {
            RingAnimation()
                .padding(20)
            
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("Share Activity")
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                    
                    Text("Invite friends to support, challenge and \ncheer each other on. Share workouts, \nreceive progress notifications and send \nmessages - direct from the Fitness app.")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                    .frame(height: 50)
                
                Button {
                    
                } label: {
                    VStack(spacing: 10) {
                        Image(systemName: "person.icloud.fill")
                            .font(.title)
                            .foregroundColor(.accentColor)
                        
                        Text("Activity data like workout types and titles, active calories or \nkilojoules, exercise minutes, stand or roll hours, steps and time zone \nwill be securely shared with the people you choose.")
                            .font(.system(size: 12))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Text("See how your data is managed...")
                            .font(.system(size: 12))
                    }
                }
                
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: .infinity, height: 60)
                            .foregroundColor(Color.darkGray)
                            
                        Text("Get Started")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .foregroundColor(.white)
                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .padding()
        }
    }
}

struct SharingView_Previews: PreviewProvider {
    static var previews: some View {
        SharingView()
    }
}

struct RingAnimation: View {
    @State private var drawingStroke = false

    let greenColor = Color(#colorLiteral(red: 0.7942436934, green: 0.9980496764, blue: 0.09652977437, alpha: 1))
    let blueColor = Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1))
 
    let animation = Animation
        .easeOut(duration: 3)
        .delay(0.5)
 
    var body: some View {
        ZStack {
            ring(for: Color.mainRed)
                .frame(width: 164)
            ring(for: greenColor)
                .frame(width: 128)
            ring(for: blueColor)
                .frame(width: 92)
        }
        .animation(animation, value: drawingStroke)
        .onAppear { drawingStroke = true  }
    }
 
    func ring(for color: Color) -> some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 16))
            .foregroundStyle(Color.darkGray)
            .overlay {
                Circle()
                    .trim(from: 0, to: drawingStroke ? 1 : 0)
                    .stroke(color.gradient,
                            style: StrokeStyle(lineWidth: 16, lineCap: .round))
            }
            .rotationEffect(.degrees(-90))
    }
}
