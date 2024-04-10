//
//  NewLibrary.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/8.
//

import SwiftUI

struct NewLibrary: View {
    
    @State private var expandSheet = false
    @State private var isMusicPlayerShowed = false
    @State private var selectedTag: String? = nil
    @Namespace private var animation
    
    @EnvironmentObject var songManager: SongManager
    
    var body: some View {
        ScrollView {
            header
            
            TagsView()
            
            QuickPlay()
            
            LargeCards()
            
            RecentPlayed()
            
        }
        .ignoresSafeArea()
        .sheet(isPresented: $isMusicPlayerShowed) {
            MusicPlayer(expandSheet: .constant(true), animation: Namespace().wrappedValue)
        }
    }
    
    // Header
    var header: some View {
        GeometryReader { size in
            VStack(alignment: .leading){
                HStack(spacing: 15) {
                    Text("Good morning GW✨")
                        .font(.title2)
                    
                    Spacer()
                    
                    Image(systemName: "bell")
                        .imageScale(.large)
                    
                    Image("GW_Avatar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, getSafeAreaTop())
        .background(LinearGradient(colors: [Color.blue, .clear], startPoint: .top, endPoint: .bottom))
        .frame(width: .infinity, height: getSafeAreaTop() * 2)
        
    }
    
    // Quick Play Songs
    @ViewBuilder func QuickPlay() -> some View {
        VStack {
            HStack {
                Text("Quick Play")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(60)), GridItem(.fixed(60)), GridItem(.fixed(60)), GridItem(.fixed(60))], content: {
                    ForEach(sampleSongModel.filter { song in
                        guard let selectedTag = selectedTag else {
                            return true
                        }
                        return song.tags.contains(selectedTag)
                    }, id:  \.id) { item in
                        HStack(spacing: 20, content: {
                            Image(item.cover)
                                .resizable()
                                .scaledToFit()
                                .background(Color.white.opacity(0.1))
                                .frame(width: 60, height: 60)
                                .clipShape(.rect(cornerRadius: 5))
                            
                            VStack(alignment: .leading) {
                                Text("\(item.title)")
                                    .font(.headline)
                                
                                Text("\(item.artist)")
                                    .font(.caption)
                            }
                            
                            Spacer()
                        })
                        .onTapGesture {
                            songManager.playSong(song: item)
                            isMusicPlayerShowed.toggle()
                        }
                    }
                    
                })
                .padding(.horizontal)
            }
        }
    }
    
    // Tags View
    @ViewBuilder func TagsView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(sampleTagList, id: \.id) {item in
                    Text(item.tag)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(RoundedRectangle(cornerRadius: 12).fill(.white.opacity(0.15)))
                        .onTapGesture {
                            if selectedTag == item.tag {
                                selectedTag = nil
                            } else {
                                selectedTag = item.tag
                            }
                        }
                }
            }
            .padding()
        }
    }
    
    // Large Cards View -> New Releases
    @ViewBuilder func LargeCards() -> some View {
        VStack {
            HStack {
                Text("New Releases")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15, content: {
                    ForEach(sampleSongModel, id: \.id) { item in
                        VStack(alignment: .leading, content: {
                            Image(item.cover)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 160, height: 160)
                                .clipShape(.rect(cornerRadius: 20))
                            
                            Text("\(item.title)")
                                .font(.headline)
                            
                            Text("\(item.artist)")
                                .font(.caption)
                        })
                        .onTapGesture {
                            songManager.playSong(song: item)
                            isMusicPlayerShowed.toggle()
                        }
                    }
                })
                .padding(.horizontal)
            }
        }
    }
    
    // Recent Played View
    @ViewBuilder func RecentPlayed() -> some View {
        VStack {
            HStack {
                Text("Recent Played")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15, content: {
                    ForEach(songManager.rencentPlayedList, id: \.id) { item in
                        VStack(alignment: .leading, content: {
                            Image(item.cover)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 160, height: 160)
                                .clipShape(.rect(cornerRadius: 20))
                            
                            Text("\(item.title)")
                                .font(.headline)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .frame(width: 160, alignment: .leading)
                            
                            Text("\(item.artist)")
                                .font(.caption)
                        })
                        .onTapGesture {
                            songManager.playSong(song: item)
                            isMusicPlayerShowed.toggle()
                        }
                    }
                })
                .padding(.horizontal)
                .padding(.bottom, 100)
            }
        }
    }
    
    
    func getSafeAreaTop() -> CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .filter({ $0.isKeyWindow }).first
        
        return (keyWindow?.safeAreaInsets.top)!
    }
    
}


#Preview {
    NewLibrary()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
