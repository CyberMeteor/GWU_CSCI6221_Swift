//
//  KaraokeOnStart.swift
//  Swift-Karaoke
//
//  Created by le sun on 4/9/24.
//

import SwiftUI

struct KaraokeOnStart: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello world")
            }
        }
        .navigationTitle("Karaoke Mode - Select a song to start")
    }
}

struct KaraokeListRow: View {
    var KaraokeSong: Song
    let song = songsDictionary["Rolling in the Deep"]   //hardcoded
    
    var body: some View {
        HStack{
            KaraokeSong.cover
                
//            .frame(height: size.width - 50)
//            .padding(.vertical, size.height < 700 ? 10: 30)
            VStack {
                Text(KaraokeSong.name)
//                HStack{
//                    let singers = KaraokeSong.singer{
//                        ForEach(singers, id:\.self) {name in
//                        Text(name)}
//                    }
            }
            Button {
                
            } label: {
                Image(systemName: "play.fill")
                    .foregroundColor(.white)
                    .padding(12)
                    .background{
                        Circle()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .light)
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

struct KaraokeOnStart_Previews: PreviewProvider {
    static var previews: some View {
        KaraokeOnStart()
            .preferredColorScheme(.dark)
    }
}
