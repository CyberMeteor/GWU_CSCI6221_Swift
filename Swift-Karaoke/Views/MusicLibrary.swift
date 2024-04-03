//
//  MusicLibrary.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/1.
//

import SwiftUI

import SwiftUI

struct MusicLibrary: View {
    // 初始化歌曲和播放列表的状态变量
    @State var songs: [Song] = [
        Song(name: "Rolling in the Deep", path: "Music_Library/Karaoke_Vocals/Adele - Rolling in the Deep (Explicit)-vocals-C minor-105bpm-440hz.mp3", authors: ["Author1"], year: 2020, genre: "Pop"),
        Song(name: "Song 2", path: "path/to/song2.mp3", authors: ["Author2"], year: 2021, genre: "Rock")
    ]
    @State var playlists: [Playlist] = []

    init() {
        // 初始化播放列表并添加歌曲
        var playlist = Playlist(name: "My Favorite Playlist")
        playlist.addSong(songs[0]) // 添加 song1
        playlist.addSong(songs[1]) // 添加 song2

        // 将初始化好的播放列表添加到状态变量中
        _playlists = State(initialValue: [playlist])
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Songs")) {
                    ForEach(songs, id: \.name) { song in
                        Button(action: {
                            // 播放选中的歌曲
                            song.playSong()
                        }) {
                            Text(song.name)
                        }
                    }
                }
                
                Section(header: Text("Playlists")) {
                    ForEach(playlists, id: \.name) { playlist in
                        Button(action: {
                            // 播放选中的播放列表
                            playlist.play()
                        }) {
                            Text(playlist.name)
                        }
                    }
                }
            }
            .navigationBarTitle("Music Library")
        }
    }
}

struct MusicLibrary_Previews: PreviewProvider {
    static var previews: some View {
        MusicLibrary()
    }
}

