//
//  ContentView.swift
//  SMSU_5
//
//  Created by Andrei Kovryzhenko on 11.10.2023.
//

import SwiftUI



struct ContentView: View {
    @GestureState private var dragging = CGSize.zero
    @State private var squarePosition = CGPoint(x: 0, y: 0)
    
    let colors: [Color] = [.white, .pink, .yellow, .black]
    
    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                ForEach(colors, id: \.self) { color in
                    Rectangle()
                        .fill(color)
                }
            }
            .ignoresSafeArea()
            
            Rectangle()
                .fill(.white)
                .blendMode(.difference)
                .overlay(
                    Rectangle()
                        .blendMode(.hue)
                )
                .overlay(
                    Rectangle()
                        .fill(.white)
                        .blendMode(.overlay)
                )
                .overlay(
                    Rectangle()
                        .fill(.black)
                        .blendMode(.overlay)
                )
                .frame(
                    width: 150,
                    height: 150
                )
                .cornerRadius(20)
                .offset(
                    x: squarePosition.x + dragging.width,
                    y: squarePosition.y + dragging.height
                )
                .gesture(
                    DragGesture()
                        .updating($dragging) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded() { value in
                            squarePosition.x += value.translation.width
                            squarePosition.y += value.translation.height
                        }
                )
                .animation(.linear, value: squarePosition)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
