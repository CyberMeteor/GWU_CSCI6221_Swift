//
//  SongManager.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/9.
//

import SwiftUI

class SongManager: ObservableObject {
    @Published private(set) var song: SongsModel = SongsModel(artist: "", audio_url: "", cover: "", title: "", exten: "")
    
    func playSong(song: SongsModel) {
        self.song = song
    }
}
