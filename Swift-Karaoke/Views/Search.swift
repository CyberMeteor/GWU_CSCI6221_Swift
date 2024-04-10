//
//  Search.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/8.
//

import SwiftUI

struct Search: View {
    
    @State var searchText: String = ""
    @State var sampleSortList = [SongsModel]()
    @State var isMusicPlayerShowed = false
    
    @EnvironmentObject var songManager: SongManager
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Search", text: $searchText)
                    .onChange(of: searchText, perform: { value in
                        sampleSortList = sampleSongModel.filter({ $0.title == searchText || $0.artist == searchText})
                    })
            }
            .padding()
            .background(.gray.opacity(0.2))
            .clipShape(Capsule())
            .padding(.horizontal)
            
            ScrollView {
                ForEach(sampleSortList) {item in
                    HStack {
                        Image(item.cover)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .clipShape(.rect(cornerRadius: 5))
                        
                        VStack(alignment: .leading, content: {
                            Text("\(item.title)")
                                .font(.headline)
                            
                            Text("\(item.artist)")
                                .font(.caption)
                        })
                        
                        Spacer()
                    }
                    .onTapGesture {
                        songManager.playSong(song: item)
                        isMusicPlayerShowed.toggle()
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $isMusicPlayerShowed) {
            MusicPlayer(expandSheet: .constant(true), animation: Namespace().wrappedValue)
        }
    }
    
    
}

#Preview {
    Search()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
