//
//  StatisticRectangle.swift
//  iSteps
//
//  Created by Данил Белов on 05.07.2023.
//

import SwiftUI

struct ActivityRectangle: View {
    var iconString: String
    var description: String
    var value: String
    var color: Color
    
    var body: some View {
        Group {
            Group {
                ZStack {
                    HStack {
                        VStack {
                            Image(systemName: iconString)
                                .resizable(resizingMode: .stretch)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 45.0, height: 45.0)
                                .foregroundColor(color)
                            Spacer()
                        }
                        Spacer()
                    }

                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text(value)
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .minimumScaleFactor(0.3)
                                    .lineLimit(1)
                                Text(description)
                                    .font(.footnote)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.secondary)
                                    .minimumScaleFactor(0.8)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
            }
            .frame(idealWidth: 140, maxWidth: 200, idealHeight: 140, maxHeight: 200)
            .padding()
        }
        .background(Color.darkGray)
        .cornerRadius(15)
    }
}
