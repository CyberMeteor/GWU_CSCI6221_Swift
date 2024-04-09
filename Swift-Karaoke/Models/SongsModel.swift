//
//  SongsModel.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/8.
//

import SwiftUI

struct SongsModel: Identifiable {
    var id: UUID = .init()
    var artist: String
    var audio_url: String
    var cover: String
    var title: String
    var exten: String
    var isFavourite: Bool = false
}

var sampleSongModel: [SongsModel] = [
    .init(artist: "Adele", audio_url: "Adele - Rolling in the Deep (Explicit)", cover: "Adele_-_Rolling_in_the_Deep", title: "Rolling in the Deep", exten: "mp3"),
    .init(artist: "Aimer", audio_url: "Aimer - Ref_rain", cover: "400px-Aimer_-_Refrain_promo", title: "Ref:rain", exten: "mp3"),
    .init(artist: "Bonnie Tyler", audio_url: "Bonnie Tyler - Total Eclipse of the Heart", cover: "Total_Eclipse_of_the_Heart_-_single_cover", title: "Total Eclipse of the Heart", exten: "wav"),
    .init(artist: "Ed Sheeran", audio_url: "Ed Sheeran-Perfect", cover: "Ed_Sheeran_Perfect_Single_cover", title: "Perfect", exten: "flac"),
    .init(artist: "Idina Menzel", audio_url: "Idina Menzel_Aurora-Into the Unknown", cover: "Frozen_2_soundtrack", title: "Into the Unknown", exten: "mp3"),
    .init(artist: "Milet", audio_url: "milet - Drown", cover: "Milet_DrownYouI", title: "Drown", exten: "mp3"),
    .init(artist: "Adele", audio_url: "When Christmas comes to town", cover: "Adele_-_Rolling_in_the_Deep", title: "When Christmas Comes to Town", exten: "mp3"),
    .init(artist: "Westlife", audio_url: "Seasons In The Sun", cover: "Westlifewestlife", title: "Seasons in the Sun", exten: "mp3")

]




//    "Seasons in the Sun": Song(
//        name: "Seasons in the Sun",
//        trackName: "Seasons In The Sun",
//        trackType: "mp3",
//        singer: ["Westlife"],
//        lyricName: "Seasons In The Sun",
//        karaokeName: "Westlife - Seasons In The Sun-accompaniment-F# major-88bpm-441hz",
//        year: 2010,
//        genre: "Soul",
//        album: "Rolling in the Deep")
//]
//
//
//
