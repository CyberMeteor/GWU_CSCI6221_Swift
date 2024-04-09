//
//  MusicLibrary.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/1.
//

import SwiftUI
import Foundation

class Song {
    var name: String
    var trackName: String
    var trackType: String
    var singer: [String]
    var lyricName: String?
    var KaraokeName: String?
    var year: Int
    var genre: String
    var playedTimes: Int
    var album: String
    var image: String
    init(name: String, trackName: String = "", trackType: String = "", singer: [String] = [], lyricName: String = "", karaokeName: String = "", year: Int = 0, genre: String = "Other", playedTimes: Int = 0, album: String = "Unknown", image: String = ""){
        self.name = name
        self.trackName = trackName
        self.trackType = trackType
        self.singer = singer
        self.lyricName = lyricName
        self.KaraokeName = karaokeName
        self.year = year
        self.genre = genre
        self.playedTimes = playedTimes
        self.album = album
        self.image = image
    }
}

let songsDictionary: [String: Song] = [
    "Rolling in the Deep": Song(
        name: "Rolling in the Deep",
        trackName: "Adele - Rolling in the Deep (Explicit)",
        trackType: "mp3",
        singer: ["Adele"],
        lyricName: "Adele_rolling_in_the_deep_english_only",
        karaokeName: "Adele - Rolling in the Deep (Explicit)-accompaniment-C minor-105bpm-440hz",
        year: 2010,
        genre: "Soul",
        album: "Rolling in the Deep",
        image: "Adele_-_Rolling_in_the_Deep"),
    "Ref:rain": Song(
        name: "Ref:rain",
        trackName: "Aimer - Ref_rain",
        trackType: "mp3",
        singer: ["Aimer"],
        lyricName: "Aimer_ref_rain_filtered",
        karaokeName: "Aimer - Ref_rain-accompaniment-G major-78bpm-441hz",
        year: 2018,
        genre: "Pop",
        album: "Ref:rain",
        image: "400px-Aimer_-_Refrain_promo"),
    "Total Eclipse of the Heart": Song(
        name: "Total Eclipse of the Heart",
        trackName: "Bonnie Tyler - Total Eclipse of the Heart",
        trackType: "wav",
        singer: ["Bonnie Tyler"],
        year: 2010,
        genre: "Rock",
        album: " Faster Than the Speed of Night",
        image:"Total_Eclipse_of_the_Heart_-_single_cover"),
    "Perfect": Song(
        name: "Perfect",
        trackName: "Ed Sheeran-Perfect",
        trackType: "flac",
        singer: ["Ed Sheeran"],
        year: 2017,
        genre: "Pop",
        album: "÷",
        image: "Ed_Sheeran_Perfect_Single_cover"),
    "Into the Unknown": Song(
        name: "Into the Unknown",
        trackName: "Idina Menzel_Aurora-Into the Unknown",
        trackType: "mp3",
        singer: ["Idina Menzel", "Aurora"],
        year: 2019,
        genre: "Pop",
        album: "Frozen II (Original Motion Picture Soundtrack)",
        image: "Frozen_2_soundtrack"),
    "Drown": Song(
        name: "Drown",
        trackName: "milet - Drown",
        trackType: "mp3",
        singer: ["Milet"],
        lyricName: "Milet_japanese_only",
        karaokeName: "milet - Drown-accompaniment-A minor-90bpm-440hz",
        year: 2019,
        genre: "J-Pop",
        album: "Drown / You & I - EP",
        image: "Milet_DrownYouI"),
    "When Christmas Comes to Town": Song(
        name: "When Christmas Comes to Town",
        trackName: "When Christmas comes to town",
        trackType: "mp3",
        singer: ["Alan Silvestri"],
        lyricName: "When Christmas comes to town",
        karaokeName: "When Christmas comes to town [music]",
        year: 2004,
        genre: "Holiday",
        album: "The Polar Express (Soundtrack from the Motion Picture)",
        image: "The_Polar_Express_soundtrack"),
    "Seasons in the Sun": Song(
        name: "Seasons in the Sun",
        trackName: "Seasons In The Sun",
        trackType: "mp3",
        singer: ["Westlife"],
        lyricName: "Seasons In The Sun",
        karaokeName: "Westlife - Seasons In The Sun-accompaniment-F# major-88bpm-441hz",
        year: 1999,
        genre: "Pop",
        album: "Westlife",
        image: "Westlifewestlife")
]

