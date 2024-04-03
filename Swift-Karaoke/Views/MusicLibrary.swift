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
    var path: String
    var authors: [String]
    var lyricPath: String
    var karaokePath: String
    var year: Int
    var genre: String
    var playedTimes: Int
    var album: String
    var rating: Int

    init(name: String, path: String = "", authors: [String] = [], lyricPath: String = "", karaokePath: String = "", year: Int = 0, genre: String = "Unknown", playedTimes: Int = 0, album: String = "Unknown", rating: Int = 0) {
        self.name = name
        self.path = path
        self.authors = authors
        self.lyricPath = lyricPath
        self.karaokePath = karaokePath
        self.year = year
        self.genre = genre
        self.playedTimes = playedTimes
        self.album = album
        self.rating = rating
    }

    func displayInfo() {
        print("Name: \(name)")
        print("Song Path: \(path)")
        print("Authors: \(authors.joined(separator: ", "))")
        print("Lyric Path: \(lyricPath)")
        print("Karaoke Path: \(karaokePath)")
        print("Year: \(year)")
        print("Genre: \(genre)")
        print("Played Times: \(playedTimes)")
        print("Album: \(album)")
        print("Rating: \(rating)")
    }

    func playSong() {
        playedTimes += 1
        print("Playing \(name)...")
    }
    func displayLyrics() {
        guard let lrcPath = URL(string: lyricPath) else {
            print("Invalid file path")
            return
        }
        
        do {
            let lrcContent = try String(contentsOf: lrcPath, encoding: .utf8)
            let lines = lrcContent.components(separatedBy: .newlines)
            var lyrics = [(time: TimeInterval, text: String)]()
            
            let pattern = "\\[(\\d+):(\\d+\\.\\d+)\\](.*)"
            let regex = try NSRegularExpression(pattern: pattern)
            
            for line in lines {
                let nsRange = NSRange(line.startIndex..<line.endIndex, in: line)
                if let match = regex.firstMatch(in: line, options: [], range: nsRange) {
                    let minutes = Double(line[Range(match.range(at: 1), in: line)!])!
                    let seconds = Double(line[Range(match.range(at: 2), in: line)!])!
                    let text = String(line[Range(match.range(at: 3), in: line)!])
                    let timeInSeconds = minutes * 60 + seconds
                    lyrics.append((time: timeInSeconds, text: text))
                }
            }
            
            let startTime = Date()
            for lyric in lyrics {
                let currentTime = Date().timeIntervalSince(startTime)
                let sleepTime = lyric.time - currentTime
                if sleepTime > 0 {
                    Thread.sleep(forTimeInterval: sleepTime)
                }
                print(lyric.text)
            }
        } catch {
            print("Failed to read the lyrics file: \(error)")
        }
    }
}


class Playlist {
    var name: String
    var songs: [Song]

    init(name: String, songs: [Song] = []) {
        self.name = name
        self.songs = songs
    }

    func addSong(_ song: Song) {
        songs.append(song)
    }

    func removeSong(_ song: Song) {
        if let index = songs.firstIndex(where: { $0 === song }) {
            songs.remove(at: index)
        }
    }

    func displaySongs() {
        print("Playlist: \(name)")
        for song in songs {
            print(song.name)
        }
    }

    func play() {
        print("Playing Playlist: \(name)")
        for song in songs {
            song.playSong()
        }
    }

    func generatePlaylistByGenre(_ genre: String) -> Playlist {
        let filteredSongs = songs.filter { $0.genre == genre }
        return Playlist(name: "\(name) - \(genre)", songs: filteredSongs)
    }

    func generatePlaylistByYear(_ year: Int) -> Playlist {
        let filteredSongs = songs.filter { $0.year == year }
        return Playlist(name: "\(name) - \(year)", songs: filteredSongs)
    }

    func generatePlaylistByAttribute(_ attribute: KeyPath<Song, String>, value: String) -> Playlist {
        let filteredSongs = songs.filter { $0[keyPath: attribute] == value }
        return Playlist(name: "\(name) - \(value)", songs: filteredSongs)
    }
}

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

