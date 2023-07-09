//
//  GraphView.swift
//  iSteps
//
//  Created by Данил Белов on 06.07.2023.
//

import SwiftUI

struct GraphView: View {
    @GestureState var isDragging: Bool = false
    @State var offset: CGFloat = 0
    @State var currentDownloadID: String = ""
    
    var steps: [Step]
    
    var body: some View {
        HStack(spacing: 5){
            ForEach(steps){step in
                CardView(step: step)
            }
        }
        .frame(height: 200)
        .animation(.easeOut, value: isDragging)
        .gesture(
            DragGesture()
                .updating($isDragging, body: { _, out, _ in
                    out = true
                })
                .onChanged({ value in
                    offset = isDragging ? value.location.x : 0

                    let  draggingSpace = UIScreen.main.bounds.width - 60
                    let eachBlock = draggingSpace / CGFloat(steps.count)
                    let temp = Int(offset / eachBlock)
                    let index = max(min(temp, steps.count - 1), 0)

                    self.currentDownloadID = steps[index].id
                })
                .onEnded({ value in
                    withAnimation {
                        offset = .zero
                        currentDownloadID = ""
                    }
                })
        )
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.darkGray)
        }
    }
    
    @ViewBuilder
    func CardView(step: Step) -> some View{
        VStack(spacing: 10){
            GeometryReader{proxy in
                
                let size = proxy.size
                
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.mainRed)
                    .opacity(isDragging ? (currentDownloadID == step.id ? 1 :
                                            0.35) : 1)
                    .frame(height: (CGFloat(step.count) / getMax()) * (size.height))
                    .padding(.horizontal, 8)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            
            if isDragging {
                Text("\(Int(step.count))")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .fixedSize()
                    .foregroundColor(isDragging && currentDownloadID == step.id ? Color.mainRed : .white)
                    .opacity(isDragging && currentDownloadID == step.id ? 1 :
                                0.3)
            }
            
            NavigationLink {
                DetailActivityView(step: step)
            } label: {
                Text("\(step.date,formatter: Date.dateFormatter(string: "E"))")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .fixedSize()
                    .foregroundColor(isDragging && currentDownloadID == step.id ? Color.mainRed : .white)
                    .opacity(isDragging && currentDownloadID == step.id ? 1 :
                                0.3)
            }
        }
    }
    
    func getMax()->CGFloat{
        let max = steps.max{first, second in
            return second.count > first.count

        }

        return CGFloat(max?.count ?? 0)
    }
}
