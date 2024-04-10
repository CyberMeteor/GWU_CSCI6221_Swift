//
//  SongManager.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/9.
//

import SwiftUI

class SongManager: ObservableObject {
    @Published private(set) var song: SongsModel = SongsModel(artist: "", audio_url: "", cover: "", title: "", exten: "", tags: [])
    @Published var rencentPlayedList: [SongsModel] = sampleSongModel
    
    func playSong(song: SongsModel) {
        self.song = song
    }
    
    // Move song to first position
    func updateSongsOrder(title: String) {
        if let index = rencentPlayedList.firstIndex(where: { $0.title == title }) {
            let songToMove = rencentPlayedList.remove(at: index)
            rencentPlayedList.insert(songToMove, at: 0)
        }
    }
}
