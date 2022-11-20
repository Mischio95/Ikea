//
//  PopupView.swift
//  ikea
//
//  Created by Michele Trombone  on 18/11/22.
//

import SwiftUI

struct PopupView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var isShowing : Bool
//    @State var productScan : Product
    @State private var curHeight : CGFloat = 500
    @State private var isDragging = false
    var minHeight : CGFloat = 500
    var maxHeight : CGFloat = 700
    let startOpacity : Double = 0.4
    let endOpacity : Double = 0.8
    var percentage : Double
    {
        let res = Double(curHeight - minHeight) / (maxHeight - minHeight)
        return max(0, min(1,res))
    }
    
    var body: some View
    {
        ZStack(alignment: .bottom)
        {
            if isShowing
            {
                Color.black
                    .opacity(startOpacity + (endOpacity - startOpacity) * percentage)
                    .ignoresSafeArea()
                    .onTapGesture{
                    isShowing = false
                    }
                
                mainView
                .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)
        
    }
    
    var mainView : some View
    {
        VStack
        {
            ZStack
            {
                Capsule()
                    .frame(width: 40,height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            
            ZStack
            {
                VStack
                {
                    Text("Ciccio bello")
                    Text("Ciccio bello 2")
                }
                .padding(.horizontal, 30)
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom,35)
        }
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background(
                // for rounded corner
                
                ZStack
                {
                    RoundedRectangle(cornerRadius: 30)
                    Rectangle()
                        .frame(height: curHeight/2)
                }
                .foregroundColor(.white)
                )
                .animation(isDragging ? nil : .easeInOut(duration: 0.45))
                .onDisappear
                {
                    curHeight = maxHeight
                }
    }
    
    
    @State private var prevDragTranslation = CGSize.zero
    var dragGesture : some Gesture
    {
        DragGesture(minimumDistance: 0,coordinateSpace: .global)
            .onChanged{ val in
                if !isDragging
                {
                    isDragging = true
                }
                let dragAmount = val.translation.height - prevDragTranslation.height
                if curHeight > maxHeight || curHeight < minHeight
                {
                    curHeight -= dragAmount / 6
                } else
                    {
                        curHeight -= dragAmount
                    }
                prevDragTranslation = val.translation
            }
            .onEnded
            {
                val in
                prevDragTranslation = .zero
                isDragging = false
                if curHeight > maxHeight
                {
                    curHeight = maxHeight
                }
                else if  curHeight < minHeight
                {
                    curHeight = minHeight
                }
            }
        
    }
    
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(isShowing: .constant(true))
    }
}

