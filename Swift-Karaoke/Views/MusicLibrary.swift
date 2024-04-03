//
//  MusicLibrary.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/1.
//

import SwiftUI

struct MusicLibrary: View {
    // 假设这里是你的播放列表数据
    let playlist = Playlist(name: "Love", songs: [
        Song(name: "歌曲1", artist: "歌手A"),
        Song(name: "歌曲2", artist: "歌手B"),
        // 添加更多歌曲
    ])
    
    var body: some View {
        NavigationView {
            List(playlist.songs) { song in
                HStack {
                    Text(song.name)
                        .bold()
                    Spacer()
                    Text(song.artist)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle(playlist.name)
        }
    }
}

struct MusicLibrary_Previews: PreviewProvider {
    static var previews: some View {
        MusicLibrary()
    }
}
