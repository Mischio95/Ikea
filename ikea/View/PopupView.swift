//
//  PopupView.swift
//  ikea
//
//  Created by Michele Trombone  on 18/11/22.
//

import SwiftUI
import SceneKit
import AVKit
import AVFoundation
var player : AVAudioPlayer!

struct PopupView: View {
    @State var isFlagged = false
    @State var isFlaggedSecondToggle = false
    @State var audioPlayer: AVAudioPlayer!
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
                    .onTapGesture
                    {
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
       
         
        VStack(alignment: .leading)
        {
            
            ZStack
            {
                Capsule()
                    .frame(width: 40,height: 6)
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            
        ScrollView(.vertical, showsIndicators: false)
        {
            VStack
            {
                Text("GOTTA CATCH' EM All")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding()
                Spacer(minLength: 30)
            
            ZStack
            {
                
                
                VStack(alignment: .center,spacing: 10)
                {
                    
                    let prodottoScannerizzato = products.ScannedProduct()
                    
                    Text(prodottoScannerizzato.name)
                        .font(.title2)
                        .ignoresSafeArea(.all)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                        .padding()
                        .offset(x:0,y: -40)
                
                    SceneView(scene: SCNScene(named: prodottoScannerizzato.image),options: [.autoenablesDefaultLighting,.allowsCameraControl])
                        .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 4)
                    
                    Spacer(minLength: 0)
                    
                    Toggle(isOn: $isFlagged) {
                        Label("PRICE", systemImage: "dollarsign.circle")
                    }
                    .toggleStyle(.switch)
                    .padding()
                    .tint(.blue)
                    .bold()
                    
                    if isFlagged
                    {
                        Text("This item has no value, it is Legendary")
                            .font(.subheadline)
                            .frame(alignment : .leading)
                            .offset(x: -40 , y: 0)
                        Divider()
                            .padding()
                    }
                    
                    
                    Toggle(isOn: $isFlaggedSecondToggle) {
                        Label("SIZE", systemImage: "arrow.up.left.and.arrow.down.right.circle")
                    }
                    .toggleStyle(.switch)
                    .padding()
                    .tint(.blue)
                    .bold()
                    
                    if isFlaggedSecondToggle
                    {
                        
                        Text(prodottoScannerizzato.dimension)
                            .font(.subheadline)
                            .frame(alignment : .leading)
                            .offset(x: -151 , y: 0)
                        Divider()
                            .padding()
                    }
                    
                    
                    
                    
                    
                    
                    
                    VStack(alignment: .leading,spacing: 15)
                    {
                        HStack(spacing : 200)
                        {
                            Text("Other info:")
                                .bold()
                                .font(.title3)
                            
                            Button(action:{
                                self.PlaySound(prodottoScannerizzato: prodottoScannerizzato)
                                let impact = UIImpactFeedbackGenerator(style: .heavy)
                                  impact.impactOccurred()
                            },label: {
                                Image(systemName: "play")
                                    .foregroundColor(.white)
                                    .padding(.vertical,20)
                                    .padding(.horizontal,20)
                                    .background(Color.blue)
                                    .cornerRadius(50)
                                
                            })
                        }
                        
                        Text(prodottoScannerizzato.description)
                            .font(.subheadline)
                        
                        
                        
                        //Spacer(minLength: -80)
                        Text("Add To Cart")
                            .foregroundColor(.white)
                            .padding(.vertical,15)
                            .padding(.horizontal,130)
                            .background(Color.blue)
                            .cornerRadius(50)
                            .frame(alignment: .center)
                        Spacer(minLength: 50)
                    }
                    .padding()
                }
                    }
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
                    RoundedRectangle(cornerRadius: 0)
                    Rectangle()
                        .frame(height: curHeight / 2)
                }
                .foregroundColor(.white)
                )
                .animation(isDragging ? nil : .easeInOut(duration: 0.45))
                .onDisappear
                {
                    curHeight = maxHeight
                }
    }
    
    // FUNZIONE PER IL PLAY SOUND
    
    func PlaySound(prodottoScannerizzato : Product)
    {
        let url = Bundle.main.url(forResource: prodottoScannerizzato.sound, withExtension: "m4a")
        guard url != nil else
        {
            return
        }
        do{
            player = try AVAudioPlayer(contentsOf: url!)
            player?.play()
        }catch
        {
            print("error")
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

