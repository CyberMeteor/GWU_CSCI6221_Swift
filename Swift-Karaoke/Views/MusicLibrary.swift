//
//  MusicLibrary.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/1.
//

import SwiftUI

struct Song: Hashable {
    var id = UUID()
    var name: String
    var artist: String
    var image: String
    var audioFilename: String
    var time: String
}

struct MusicLibrary: View {
    var songs = [Song(name: "song 1", artist: "artist 1", image: "mm", audioFilename: "Tuesday", time: "2:36"),
                 Song(name: "song 2", artist: "artist 2", image: "1", audioFilename: "Tuesday", time: "2:36"),
                 Song(name: "song 3", artist: "artist 3", image: "2", audioFilename: "Tuesday", time: "2:36"),
                 Song(name: "song 4", artist: "artist 4", image: "1", audioFilename: "Tuesday", time: "2:36")]
    
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    
    @State private var currentSong: Song?
    @State private var showMusicPlayer = false
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Good Morning, Le")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                VStack {
                    // MARK: -Recent Played
                    Text("Recent Played")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 5)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 17) {
                            HStack {
                                ForEach(self.songs, id: \.self) { song in
                                    RecentPlayed(song: song, currentSong: $currentSong, showMusicPlayer: $showMusicPlayer)
                                }
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }
                }
                // MARK: -Play by Genres
                Text("Play by Genres")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 15)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 17) {
                        VStack {
                            Button {
                                // to rock playlist
                            } label: {
                                Image("rock")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 130, height: 130)
                                    .clipped()
                                    .cornerRadius(15)
                            }
                            Text("Rock")
                                .font(.subheadline)
                        }
                        
                        VStack {
                            Button {
                                // to country playlist
                            } label: {
                                Image("country")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 130, height: 130)
                                    .clipped()
                                    .cornerRadius(15)
                            }
                            Text("Country")
                                .font(.subheadline)
                        }
                        
                        VStack {
                            Button {
                                // to pop playlist
                            } label: {
                                Image("pop")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 130, height: 130)
                                    .clipped()
                                    .cornerRadius(15)
                            }
                            Text("Pop")
                                .font(.subheadline)
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                // MARK: -Play by Artists
                Text("Play by Artists")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 17) {
                        VStack {
                            Button {
                                
                            } label: {
                                Image("rock")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 130, height: 130)
                                    .clipped()
                                    .cornerRadius(15)
                            }
                            Text("name 1")
                                .font(.subheadline)
                        }
                        
                        VStack {
                            Button {
                                
                            } label: {
                                Image("country")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 130, height: 130)
                                    .clipped()
                                    .cornerRadius(15)
                            }
                            Text("name 2")
                                .font(.subheadline)
                        }
                        
                        VStack {
                            Button {
                                
                            } label: {
                                Image("pop")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 130, height: 130)
                                    .clipped()
                                    .cornerRadius(15)
                            }
                            Text("name 3")
                                .font(.subheadline)
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                // MARK: -Play by Albums
                Text("Play by Albums")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 17) {
                        Rectangle()
                            .fill(.gray)
                        
                        Rectangle()
                            .fill(.gray)
                        
                        Rectangle()
                            .fill(.gray)
                        
                        Rectangle()
                            .fill(.gray)
                    }
                    .padding([.horizontal, .bottom])
                }
            }
        }
        // popup musicplayer view
        .sheet(isPresented: $showMusicPlayer) {
            if let currentSong = currentSong {
                MusicPlayer(expandSheet: $showMusicPlayer, animation: Namespace().wrappedValue)
            }
        }
    }
}


struct RecentPlayed: View {
    var song: Song
    @Binding var currentSong: Song?
    @Binding var showMusicPlayer: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(song.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 180, alignment: .center)
            
            ZStack {
                Rectangle()
                    .fill(.gray)
                    .overlay {
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Text(song.name)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                
                                Text(song.artist)
                                    .font(.caption2)
                                    .foregroundStyle(.white)
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Button {
                                currentSong = song
                                showMusicPlayer = true
                            } label: {
                                Image("play")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                            }
                            .padding(5)
                        }
                    }
            }
            .frame(height: 50, alignment: .center)
        }
        .clipped()
        .cornerRadius(15)
    }
}


struct MusicLibrary_Previews: PreviewProvider {
    static var previews: some View {
        MusicLibrary(expandSheet: .constant(true), animation: Namespace().wrappedValue)
    }
}
