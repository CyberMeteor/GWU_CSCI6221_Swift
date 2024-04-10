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
            KaraokePlayList()
                .tabItem() {
                    Image(systemName: "music.mic")
                    Text("Karaoke")
                }
            
            ListenTogether()
                .tabItem() {
                    Image(systemName: "person.3.fill")
                    Text("Share")
                }
            
            MusicPlayer(expandSheet: .constant(true), animation: Namespace().wrappedValue)
                .tabItem() {
                        Image(systemName: "play.circle")
                            .foregroundColor(.red)
                            .padding(.vertical, 6)
                    Text("Listening")
                        .multilineTextAlignment(.center)
                }
            
//            MusicLibrary()
//                .tabItem() {
//                    Image(systemName: "bookmark.circle")
//                        .foregroundColor(.red)
//                        .padding(.vertical, 6)
//                    Text("Library")
//                }
            
            Profile()
                .tabItem() {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.red)
                        .padding(.vertical, 6)
                    Text("Profile")
                }
        }
        .accentColor(.purple)
        .onAppear() {
            let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            UITabBar.appearance().backgroundColor = backgroundColor
            UITabBar.appearance().layer.opacity = 0.9
            UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.8)
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

