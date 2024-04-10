//
//  ContentView.swift
//  Swift-Karaoke
//
//  Created by Robert Zhang on 3/20/24.
//


import SwiftUI

struct ContentView: View {
    
    @StateObject var songManager = SongManager()
    
    var body: some View {
        TabView {
            KaraokeMode(songName: "Perfect")
                .tabItem() {
                    Image(systemName: "music.mic.circle.fill")
                    Text("Karaoke")
                }
            
//            ListenTogether()
//                .tabItem() {
//                    Image(systemName: "person.3.fill")
//                    Text("Share")
//                }
            
            NewLibrary()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                .tabItem() {
                    Image(systemName: "bookmark.circle")
                    Text("Library")
                }
                .environmentObject(songManager)

                
            
            MusicPlayer(expandSheet: .constant(true), animation: Namespace().wrappedValue)
                .tabItem() {
                    Image(systemName: "play.circle")
                    Text("Listening")
                }
                .environmentObject(songManager)
            
//            MusicLibrary()
//                .tabItem() {
//                    Image(systemName: "bookmark.circle")
//                        .foregroundColor(.red)
//                        .padding(.vertical, 6)
//                    Text("Library")
//                }
            
            Search()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                .tabItem() {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
                }
                .environmentObject(songManager)
            
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

