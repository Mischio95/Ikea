//
//  SplashScreen.swift
//  ikea
//
//  Created by Michele Trombone  on 15/11/22.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var animate = false
    @State var end = false
    
    var body: some View {
        ZStack
        {
            ContentView()
            ZStack
            {
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                Image("IkeaSplashScreen")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150,height: 150,alignment: .center)
                    .scaleEffect(animate ? 4 : 1 )
                
                    .frame(width: UIScreen.main.bounds.width)
                
            }.ignoresSafeArea(.all,edges: .all)
                .onAppear(perform: {
                    AnimateSplash()
                })
                .opacity(end ? 0 : 2)
        }
    }
    
    func AnimateSplash()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.00)
        {
            withAnimation(Animation.easeOut(duration: 0.45))
            {
                animate.toggle()
            }
            withAnimation(Animation.easeOut(duration: 0.75))
            {
                end.toggle()
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
