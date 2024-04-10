//
//  KaraokePlayList.swift
//  Swift-Karaoke
//
//  Created by le sun on 4/9/24.
//

import SwiftUI

struct KaraokePlayList: View {
    @State private var songOrder: [String]
    @State private var draggedItem: String? = nil
        
    init() {
        // Filter songs with a non-empty lyricName and collect their names
        let filteredSongNames = songsDictionary
            .filter { $0.value.lyricName != nil && !$0.value.lyricName!.isEmpty }
            .map { $0.key }
        
        // Initialize songOrder with filtered song names
        songOrder = filteredSongNames
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay(content: {
                        Rectangle()
                        Image("mm")
                            .blur(radius: 55)
                    })
                VStack(alignment:.leading){
                    Text("Karaoke Mode")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.vertical, 1)
                    Text("Select a song to start singing.")
                        .foregroundColor(.white)
                        .padding(.vertical, 3)
                    
                    ScrollView {
                        // Generate a KaraokeListRow for each song in songOrder
                        ForEach(songOrder, id: \.self) { songName in
                            let song = songsDictionary[songName]
                                KaraokeListRow(KaraokeSong: song!)
                                    .padding(.vertical, 5)
                            }
                            .onMove(perform: move)
                        }
                    }
                }
            .padding(20)
        }
    }
    // function to perform dragging songs to move
    private func move(from source: IndexSet, to destination: Int) {
            songOrder.move(fromOffsets: source, toOffset: destination)
        }
}

struct KaraokeListRow: View {
    var KaraokeSong: Song
    var body: some View {
        HStack{
            Image(KaraokeSong.image)
                .resizable()
                .frame(width: 85, height: 85)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack (alignment: .leading) {
                Text(KaraokeSong.name)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.primary)
                ForEach(KaraokeSong.singer, id: \.self) { name in
                    Text(name)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .foregroundColor(Color.primary)
                }
            }
            .padding(.horizontal, 5)
            Spacer()
            
            Button(action: {
                // Implement your play button action
            }) {
                NavigationLink(destination: KaraokeMode(songName: KaraokeSong.name)) {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .padding(12)
                        .background(
                            Circle()
                                .fill(Color.purple)
                        )
                }
            }
        }
        .background(.clear)
    }
}

struct KaraokePlayList_Previews: PreviewProvider {
    static var previews: some View {
        KaraokePlayList()
//            .preferredColorScheme(.dark)
    }
}
