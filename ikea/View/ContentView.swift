//
//  ContentView.swift
//  ikea
//
//  Created by Michele Trombone  on 15/11/22.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        
        TabView
        {
            SettingView()
            .tabItem
            {
                    Label("", systemImage: "house")
                    
            }
            SettingView()
                .tabItem
            {
                    Label("", systemImage: "magnifyingglass")
                    
            }
            SettingView()
                .tabItem
            {
                    Label("", systemImage: "person")
            }
            SettingView()
                .tabItem
            {
                    Label("", systemImage: "heart")
            }
            SettingView()
                .tabItem
            {
                    Label("", systemImage: "cart")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
