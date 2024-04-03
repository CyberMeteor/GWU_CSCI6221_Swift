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




//testing
////////////////////////////////
/*
func testDisplayLyrics() {
    // 此处假设LRC文件名为"Adele_rolling_in_the_deep_english_only.lrc"，并已添加到项目中
    let song = Song(name: "Rolling in the Deep",
                    path: "Music_Library/Karaoke_Vocals/Adele - Rolling in the Deep (Explicit)-vocals-C minor-105bpm-440hz.mp3",
                    authors: ["Adele"],
                    lyricPath: "Adele_rolling_in_the_deep_english_only.lrc", // 此处使用文件名，确保与项目中的文件名匹配
                    year: 2010,
                    genre: "Pop")
    
    // 调用displayLyrics方法
    song.displayLyrics()
}

// 运行测试函数
testDisplayLyrics()

RunLoop.main.run(until: Date(timeIntervalSinceNow: 60))

*/