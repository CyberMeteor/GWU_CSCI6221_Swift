//
//  MusicLibrary.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/1.
//

import SwiftUI
import Foundation

class Song {
    var audioFileName: String
    var authors: [String]
    var lyricPath: String
    var karaokePath: String
    var year: String
    var genre: String
    var playedTimes: Int
    var album: String
    var rating: Int
    var image: String

    init(audioFileName: String, authors: [String] = [], lyricPath: String = "", karaokePath: String = "", year: String, genre: String = "Unknown", playedTimes: Int = 0, album: String = "Unknown", rating: Int = 0, image: String) {
        self.audioFileName = audioFileName
        self.authors = authors
        self.lyricPath = lyricPath
        self.karaokePath = karaokePath
        self.year = year
        self.genre = genre
        self.playedTimes = playedTimes
        self.album = album
        self.rating = rating
        self.image = image
    }
}

class RecentPlayedList: ObservableObject {
    static let shared = RecentPlayedList()
    @Published var songs: [Song] = [Song(audioFileName: "Ref_rain", authors: ["Aimer"], lyricPath: "Aimer_ref_rain_filtered", year: "2018", genre: "rock", album: "Sun Dance & Penny Rain", image: "aimer_ref_rain"),
                         
                         Song(audioFileName: "Drown", authors: ["Milet"], lyricPath: "Milet_japanese_only", year: "2019", genre: "country", album: "Inside You", image: "milet_drown"),
                         
                         Song(audioFileName: "Tuesday", authors: ["Tony's Relaxation"], lyricPath: "", year: "", genre: "", album: "", image: "mm"),
                         
                         Song(audioFileName: "Seasons In The Sun", authors: ["Westlife"], lyricPath: "season_in_the_sun_english_only", year: "1999", genre: "pop", album: "Westlife", image: "westlift_season in the sun"),
                         
                         Song(audioFileName: "When Christmas comes to town", authors: ["Hanks"], lyricPath: "When Christmas comes to town", year: "2004", genre: "pop", album: "The Polar Express: Original Motion Picture Soundtrack", image: "when christmas comes to town"),
                         
                         Song(audioFileName: "Rolling in the Deep", authors: ["Adele"], lyricPath: "Adele_rolling_in_the_deep_english_only", year: "2011", genre: "pop", album: "21", image: "adele_rolling in the deep")]
    
    func addSong(_ newSong: Song) {
        songs.insert(newSong, at: 0)
        if songs.count > 8 {
            songs.removeLast()
        }
    }
    
    func updateSongsOrder(audioFileName: String) {
        if let index = songs.firstIndex(where: { $0.audioFileName == audioFileName }) {
            let songToMove = songs.remove(at: index)
            songs.insert(songToMove, at: 0)
        }
    }
}

struct MusicLibrary: View {
    @ObservedObject var recentPlayedList = RecentPlayedList.shared
    let maxCapacity: Int = 8
    
    // 控制'MusicPlayer()'视图展开
    @Binding var expandSheet: Bool
    
    // 'Namespace' 用于创建一个命名空间，允许在视图间匹配动画，
    // 每个命名空间唯一，通过它的 ID 标识，
    // 进行视图转换时，指定相同的命名空间创建过渡动画
    var animation: Namespace.ID
    
    // MARK: -popup sheet var
    // 点'play'按钮后，'currentSong'接收对应的'Song'的实例 （253行）
    @State var currentSong: Song?
    
    // 点'play'按钮后，更新'showMusicPlayer'的值为'true' （254行）
    // 'showMusicPlayer'被赋值给 'expandSheet'; 'expandSheet'作为参数传递给 'MusicPlayer()' （211行）
    @State var showMusicPlayer = false
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Good Morning, Le")
                    .font(.title).fontWeight(.bold).frame(maxWidth: .infinity, alignment:.leading).padding(.leading)
                
                VStack {
                    // MARK: -Recent Played
                    Text("Recent Played")
                        .font(.title2).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal).padding(.top, 5)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 17)  {
                            // 'ForEach' 遍历 'songs' 列表中的元素('Song'实例)，
                            // 为每个'Song'实例 生成一个 'RecentPlayedSong()' 视图 (218行)
                            ForEach(recentPlayedList.songs, id: \.audioFileName) { song in
                                RecentPlayedSong(song: song, currentSong: $currentSong, showMusicPlayer: $showMusicPlayer)
                            }
                        }.padding([.horizontal, .bottom])
                    }
                }
                // MARK: -Play by Genres
                Text("Play by Genres")
                    .font(.title2).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal).padding(.top, 15)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 17) {
                        VStack {
                            Button {
                                // to rock playlist
                            } label: {
                                Image("rock")
                                    .resizable().aspectRatio(contentMode: .fill).frame(width: 130, height: 130).clipped().cornerRadius(15)
                            }
                            Text("Rock")
                                .font(.subheadline)
                        }
                        
                        VStack {
                            Button {
                                // to country playlist
                            } label: {
                                Image("country")
                                    .resizable().aspectRatio(contentMode: .fill).frame(width: 130, height: 130).clipped().cornerRadius(15)
                            }
                            Text("Country")
                                .font(.subheadline)
                        }
                        
                        VStack {
                            Button {
                                // to pop playlist
                            } label: {
                                Image("pop")
                                    .resizable().aspectRatio(contentMode: .fill).frame(width: 130, height: 130).clipped().cornerRadius(15)
                            }
                            Text("Pop")
                                .font(.subheadline)
                        }
                    }.padding([.horizontal, .bottom])
                }
                // MARK: -Play by Artists
                Text("Play by Artists")
                    .font(.title2).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 17) {
                        VStack {
                            Button {
                                
                            } label: {
                                Image("rock")
                                    .resizable().aspectRatio(contentMode: .fill).frame(width: 130, height: 130).clipped().cornerRadius(15)
                            }
                            Text("name 1")
                                .font(.subheadline)
                        }
                        
                        VStack {
                            Button {
                                
                            } label: {
                                Image("country")
                                    .resizable().aspectRatio(contentMode: .fill).frame(width: 130, height: 130).clipped().cornerRadius(15)
                            }
                            Text("name 2")
                                .font(.subheadline)
                        }
                        
                        VStack {
                            Button {
                                
                            } label: {
                                Image("pop")
                                    .resizable().aspectRatio(contentMode: .fill).frame(width: 130, height: 130).clipped().cornerRadius(15)
                            }
                            Text("name 3")
                                .font(.subheadline)
                        }
                    }.padding([.horizontal, .bottom])
                }
                // MARK: -Play by Albums
                Text("Play by Albums")
                    .font(.title2).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 17) {
                        Rectangle()
                            .fill(.gray)
                        
                        Rectangle()
                            .fill(.gray)
                        
                        Rectangle()
                            .fill(.gray)
                        
                        Rectangle()
                            .fill(.gray)
                    }
                    .padding([.horizontal, .bottom])
                }
            }
        }
        .sheet(isPresented: $showMusicPlayer) {
                MusicPlayer(currentSong: currentSong, expandSheet: $showMusicPlayer, animation: Namespace().wrappedValue)
        }
    }
}


//MARK: -Recent Played
struct RecentPlayedSong: View {
    var song: Song
    @Binding var currentSong: Song?
    @Binding var showMusicPlayer: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(song.image)
                .resizable().aspectRatio(contentMode: .fill).frame(width: 150, height: 180, alignment: .center)
            
            ZStack {
                Rectangle()
                    .fill(.gray)
                    .overlay {
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Text(song.audioFileName)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                
                                Text(song.authors[0])
                                    .font(.caption2)
                                    .foregroundStyle(.white)
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Button {
                                print("Playing: \(song.audioFileName)")
                                showMusicPlayer = true
                                currentSong = song
                                song.playedTimes += 1
                                RecentPlayedList.shared.updateSongsOrder(audioFileName: song.audioFileName)
                            } label: {
                                Image("play")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                            }
                            .padding(5)
                        }
                    }
            }.frame(height: 50, alignment: .center)
        }.clipped().cornerRadius(15)
    }
}

struct MusicLibrary_Previews: PreviewProvider {
    static var previews: some View {
        MusicLibrary(expandSheet: .constant(true), animation: Namespace().wrappedValue)
    }
}
