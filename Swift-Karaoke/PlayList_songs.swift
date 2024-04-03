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




//testing
////////////////////////////////

let song1 = Song(name: "Song 1", path: "Music_Library/Karaoke_Vocals/Adele - Rolling in the Deep (Explicit)-vocals-C minor-105bpm-440hz.mp3", authors: ["Author1"], year: 2020, genre: "Pop")
let song2 = Song(name: "Song 2", path: "path/to/song2.mp3", authors: ["Author2"], year: 2021, genre: "Rock")

// 创建Playlist实例并添加歌曲
let playlist = Playlist(name: "My Favorite Playlist")
playlist.addSong(song1)
playlist.addSong(song2)

// 显示播放列表中的歌曲名称
playlist.displaySongs()

// 播放播放列表
playlist.play()