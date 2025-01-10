//
//  homeDrawer.swift
//  Countorama
//
//  Created by Raj Singh on 04/01/25.
//

import SwiftUI
//TODO: Make a seperate drawer and customizable one

struct HomeDrawer: View {
    @Binding var isOn:Bool
    
    @State private var currentDragPosition: CGPoint = .zero
    @State private var previousDragPosition: CGPoint = .zero
    @State private var currentDrawerWidth:Double = 0;
    var drag : some Gesture{
        
        DragGesture()
            .onChanged { value in currentDragPosition = value
                    .location
                let offset =  currentDragPosition.x - previousDragPosition.x
                currentDrawerWidth = max(0.0, min(currentDrawerWidth + offset / UIScreen.main.bounds.width,0.7 ))
                
                previousDragPosition = currentDragPosition
                
            }
            .onEnded {
                value in
                if currentDrawerWidth > 0.5 {
                    withAnimation {
                        currentDrawerWidth = 0.7
                        isOn = true
                        
                    }
                } else {
                    withAnimation {
                        currentDrawerWidth = 0.7
                        isOn = false
                    }
                }
                
                
                
                
            }
    }
    var body: some View {
        GeometryReader{
            geometry in
            
            ZStack(alignment:.leading){
                
                Rectangle()
                    .frame(width: geometry.size.width*(isOn ? currentDrawerWidth:0), height: geometry.size.height)
                    .foregroundColor(Color( .systemGray6 ))
                    .shadow(radius: 6)
                
                
                
                
            }
        }
        .onAppear{
            currentDrawerWidth = 0.7
        }
        .gesture(drag)
        .animation(.spring,value: isOn)
        .ignoresSafeArea()
        
    }
}

#Preview {
    HomeDrawer(isOn: .constant(true))
}
