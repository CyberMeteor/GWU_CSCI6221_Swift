//
//  KaraokePlayList.swift
//  Swift-Karaoke
//
//  Created by le sun on 4/9/24.
//

import SwiftUI

struct KaraokePlayList: View {
    
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
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.vertical, 1)
                    Text("Select a song to start singing.")
                        .padding(.vertical, 3)
                    ScrollView {
                        // Iterate over each item in songsDictionary
                        ForEach(songsDictionary.sorted(by: { $0.key < $1.key }), id: \.key) { (songName, song) in
                            if let lyricName = song.lyricName, !lyricName.isEmpty {
                                // Generate a KaraokeListRow for each song that has lyrics
                                KaraokeListRow(KaraokeSong: song)
                                    .padding(.vertical, 5)
                            }
                            
                        }
                    }
                }
                .padding(.leading, 20)
            }
        }
    }}

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
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.primary)
                ForEach(KaraokeSong.singer, id: \.self) { name in
                    Text(name)
                        .font(.subheadline)
                        .foregroundColor(Color.primary)
                }
            }
            .padding(.horizontal, 10)
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
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.white)
                    .padding(12)
                    .background{
                        Circle()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .light)
                    }
            }
        }
    }
}

struct KaraokePlayList_Previews: PreviewProvider {
    static var previews: some View {
        KaraokePlayList()
            .preferredColorScheme(.dark)
    }
}
