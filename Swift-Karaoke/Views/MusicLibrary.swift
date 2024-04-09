////
////  MusicLibrary.swift
////  Swift-Karaoke
////
////  Created by Ruiyang Chen on 2024/4/1.
////
//
//import SwiftUI
//import Foundation
//
//class Song {
//    var name: String
//    var path: String
//    var authors: [String]
//    var lyricPath: String
//    var karaokePath: String
//    var year: Int
//    var genre: String
//    var playedTimes: Int
//    var album: String
//    var rating: Int
//
//    init(name: String, path: String = "", authors: [String] = [], lyricPath: String = "", karaokePath: String = "", year: Int = 0, genre: String = "Unknown", playedTimes: Int = 0, album: String = "Unknown", rating: Int = 0) {
//        self.name = name
//        self.path = path
//        self.authors = authors
//        self.lyricPath = lyricPath
//        self.karaokePath = karaokePath
//        self.year = year
//        self.genre = genre
//        self.playedTimes = playedTimes
//        self.album = album
//        self.rating = rating
//    }
//
//    func displayInfo() {
//        print("Name: \(name)")
//        print("Song Path: \(path)")
//        print("Authors: \(authors.joined(separator: ", "))")
//        print("Lyric Path: \(lyricPath)")
//        print("Karaoke Path: \(karaokePath)")
//        print("Year: \(year)")
//        print("Genre: \(genre)")
//        print("Played Times: \(playedTimes)")
//        print("Album: \(album)")
//        print("Rating: \(rating)")
//    }
//
//    func playSong() {
//        playedTimes += 1
//        print("Playing \(name)...")
//    }
//    func displayLyrics() {
//        guard let lrcPath = URL(string: lyricPath) else {
//            print("Invalid file path")
//            return
//        }
//        
//        do {
//            let lrcContent = try String(contentsOf: lrcPath, encoding: .utf8)
//            let lines = lrcContent.components(separatedBy: .newlines)
//            var lyrics = [(time: TimeInterval, text: String)]()
//            
//            let pattern = "\\[(\\d+):(\\d+\\.\\d+)\\](.*)"
//            let regex = try NSRegularExpression(pattern: pattern)
//            
//            for line in lines {
//                let nsRange = NSRange(line.startIndex..<line.endIndex, in: line)
//                if let match = regex.firstMatch(in: line, options: [], range: nsRange) {
//                    let minutes = Double(line[Range(match.range(at: 1), in: line)!])!
//                    let seconds = Double(line[Range(match.range(at: 2), in: line)!])!
//                    let text = String(line[Range(match.range(at: 3), in: line)!])
//                    let timeInSeconds = minutes * 60 + seconds
//                    lyrics.append((time: timeInSeconds, text: text))
//                }
//            }
//            
//            let startTime = Date()
//            for lyric in lyrics {
//                let currentTime = Date().timeIntervalSince(startTime)
//                let sleepTime = lyric.time - currentTime
//                if sleepTime > 0 {
//                    Thread.sleep(forTimeInterval: sleepTime)
//                }
//                print(lyric.text)
//            }
//        } catch {
//            print("Failed to read the lyrics file: \(error)")
//        }
//    }
//}
//
//
//class Playlist {
//    var name: String
//    var songs: [Song]
//
//    init(name: String, songs: [Song] = []) {
//        self.name = name
//        self.songs = songs
//    }
//
//    func addSong(_ song: Song) {
//        songs.append(song)
//    }
//
//    func removeSong(_ song: Song) {
//        if let index = songs.firstIndex(where: { $0 === song }) {
//            songs.remove(at: index)
//        }
//    }
//
//    func displaySongs() {
//        print("Playlist: \(name)")
//        for song in songs {
//            print(song.name)
//        }
//    }
//
//    func play() {
//        print("Playing Playlist: \(name)")
//        for song in songs {
//            song.playSong()
//        }
//    }
//
//    func generatePlaylistByGenre(_ genre: String) -> Playlist {
//        let filteredSongs = songs.filter { $0.genre == genre }
//        return Playlist(name: "\(name) - \(genre)", songs: filteredSongs)
//    }
//
//    func generatePlaylistByYear(_ year: Int) -> Playlist {
//        let filteredSongs = songs.filter { $0.year == year }
//        return Playlist(name: "\(name) - \(year)", songs: filteredSongs)
//    }
//
//    func generatePlaylistByAttribute(_ attribute: KeyPath<Song, String>, value: String) -> Playlist {
//        let filteredSongs = songs.filter { $0[keyPath: attribute] == value }
//        return Playlist(name: "\(name) - \(value)", songs: filteredSongs)
//    }
//}
//
//
//struct MusicLibrary: View {
//    @State var songs: [Song] = [
//        Song(name: "Rolling in the Deep", path: "Music_Library/Karaoke_Vocals/Adele - Rolling in the Deep (Explicit)-vocals-C minor-105bpm-440hz.mp3", authors: ["Author1"], year: 2020, genre: "Pop"),
//        Song(name: "Song 2", path: "path/to/song2.mp3", authors: ["Author2"], year: 2021, genre: "Rock")
//    ]
//    @State var playlists: [Playlist] = []
//    @State private var showingPlaylistSelection = false
//    @State private var selectedSong: Song?
//
//    init() {
//        
//        let songs: [Song] = [
//            Song(name: "Rolling in the Deep", path: "Music_Library/Karaoke_Vocals/Adele - Rolling in the Deep (Explicit)-vocals-C minor-105bpm-440hz.mp3", authors: ["Adele Adkins", "Paul Epworth"], year: 2010, genre: "Pop", album: "21"),
//            Song(name: "Someone Like You", path: "Music_Library/Karaoke_Vocals/Adele - Someone Like You-vocals-C minor-105bpm-440hz.mp3", authors: ["Adele Adkins", "Dan Wilson"], year: 2011, genre: "Pop", album: "21"),
//            
//        ]
//        let myFavoritePlaylist = Playlist(name: "My Favorite Playlist", songs: [songs[0], songs[1]])
//        
//        
//        let popSongs = songs.filter { $0.genre == "Pop" }
//        let popPlaylist = Playlist(name: "Pop", songs: popSongs)
//        
//        
//        _playlists = State(initialValue: [myFavoritePlaylist, popPlaylist])
//        
//        
//        _songs = State(initialValue: songs)
//    }
//
//
//    var body: some View {
//        NavigationView {
//            List {
//                Section(header: Text("Songs")) {
//                    ForEach(songs, id: \.name) { song in
//                        HStack {
//                            // 歌曲名作为按钮，点击播放歌曲
//                            Button(song.name) {
//                                song.playSong()
//                            }
//                            Spacer()
//                            // 加号按钮用于添加歌曲到播放列表
//                            Button(action: {
//                                self.selectedSong = song
//                                self.showingPlaylistSelection = true
//                            }) {
//                                Image(systemName: "plus")
//                            }.buttonStyle(BorderlessButtonStyle()) // 使用无边框按钮样式，避免影响布局
//                        }
//                    }
//                }
//
//                Section(header: Text("Playlists")) {
//                    ForEach(playlists, id: \.name) { playlist in
//                        Button(action: {
//                            playlist.play()
//                        }) {
//                            Text(playlist.name)
//                        }
//                    }
//                }
//            }
//            .navigationBarTitle("Music Library")
//            .sheet(isPresented: $showingPlaylistSelection) {
//                PlaylistSelectionView(playlists: $playlists, selectedSong: $selectedSong)
//            }
//        }
//    }
//}
//
//
//
//
//struct PlaylistSelectionView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var playlists: [Playlist]
//    @Binding var selectedSong: Song?
//    @State private var newPlaylistName: String = ""
//
//    var body: some View {
//        NavigationView {
//            List {
//                Section(header: Text("新建播放列表")) {
//                    HStack {
//                        TextField("播放列表名称", text: $newPlaylistName)
//                        Button(action: {
//                            addNewPlaylist()
//                        }) {
//                            Image(systemName: "plus.circle.fill")
//                                .foregroundColor(.green)
//                        }
//                    }
//                }
//                
//                Section(header: Text("现有播放列表")) {
//                    ForEach(playlists, id: \.name) { playlist in
//                        Button(action: {
//                            addToPlaylist(playlist: playlist)
//                        }) {
//                            Text(playlist.name)
//                        }
//                    }
//                }
//            }
//            .navigationBarTitle(Text("选择播放列表"), displayMode: .inline)
//        }
//    }
//
//    private func addNewPlaylist() {
//        guard !newPlaylistName.isEmpty else { return }
//        let newPlaylist = Playlist(name: newPlaylistName)
//        if let song = selectedSong {
//            newPlaylist.addSong(song)
//            playlists.append(newPlaylist)
//            newPlaylistName = ""
//            // 添加成功后关闭视图
//            presentationMode.wrappedValue.dismiss()
//        }
//    }
//
//
//    private func addToPlaylist(playlist: Playlist) {
//        guard let song = selectedSong else { return }
//        if !playlist.songs.contains(where: { $0.name == song.name }) {
//            playlist.addSong(song)
//
//            presentationMode.wrappedValue.dismiss()
//        }
//    }
//}
