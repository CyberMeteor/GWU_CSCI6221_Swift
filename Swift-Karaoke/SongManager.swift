//
//  SongManager.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/9.
//

import SwiftUI

class SongManager: ObservableObject {
    @Published private(set) var song: SongsModel = SongsModel(artist: "", audio_url: "", cover: "", title: "", exten: "", tags: [])
    
    // copy list of all songs (for recent play)
    @Published var rencentPlayedList: [SongsModel] = sampleSongModel
    
    func setSong(song: SongsModel) {
        self.song = song
    }
    
    // get next song index
    func nextSong(title: String) {
        if var index = sampleSongModel.firstIndex(where: { $0.title == title }) {
            if index == sampleSongModel.count - 1 {
                index = 0
                setSong(song: sampleSongModel[index])
            } else {
                index += 1
                setSong(song: sampleSongModel[index])
            }
        }
    }
    
    // get previous song index
    func previousSong(title: String) {
        if var index = sampleSongModel.firstIndex(where: { $0.title == title }) {
            if index == 0 {
                index = sampleSongModel.count - 1
                setSong(song: sampleSongModel[index])
            } else {
                index -= 1
                setSong(song: sampleSongModel[index])
            }
        }
    }
    
    // Move song to first position in copyed list
    func updateSongsOrder(title: String) {
        if let index = rencentPlayedList.firstIndex(where: { $0.title == title }) {
            let songToMove = rencentPlayedList.remove(at: index)
            rencentPlayedList.insert(songToMove, at: 0)
        }
    }
}
