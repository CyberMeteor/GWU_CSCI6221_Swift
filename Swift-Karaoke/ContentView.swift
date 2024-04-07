//
//  ContentView.swift
//  Swift-Karaoke
//
//  Created by Robert Zhang on 3/20/24.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            KaraokeMode()
                .tabItem() {
                    Image(systemName: "music.mic")
                }
            
            ListenTogether()
                .tabItem() {
                    Image(systemName: "person.3.fill")
                }
            
            MusicPlayer(expandSheet: .constant(true), animation: Namespace().wrappedValue)
                .tabItem() {
                    Image(systemName: "play.circle")
                }
            
            MusicLibrary()
                .tabItem() {
                    Image(systemName: "bookmark.circle")
                }
            
            Profile()
                .tabItem() {
                    Image(systemName: "person.crop.circle")
                }
        }
        .onAppear() {
            UITabBar.appearance().barTintColor = UIColor(.gray)
            UITabBar.appearance().backgroundColor = .systemGray5
            UITabBar.appearance().unselectedItemTintColor = .darkGray
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

