//
//  Profile.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/1.
//

import SwiftUI

struct Profile: View {
    let profileImage = "profilePlaceholder" // 头像图片名称
    let userName = "Student beg for A"
    let userDescription = "Karaoke enthusiast. Love to explore new songs and share with friends."
    let topSongs = [
        ("Song Title 1", "albumCover1"), // 歌曲标题和对应的专辑封面图片名称
        ("Song Title 2", "albumCover2"),
        ("Song Title 3", "albumCover3")
    ]

    var body: some View {
        VStack {
            // 头像
            Image(profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .shadow(radius: 5)
                .padding(.top, 20)
            
            // 用户名
            Text(userName)
                .font(.title)
                .padding(.top, 10)
            
            // 用户描述
            Text(userDescription)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // 最多听歌曲的排名和专辑封面
            VStack(alignment: .leading) {
                Text("Top Songs")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(topSongs, id: \.0) { song in
                    HStack {
                        Image(song.1) // 专辑封面图片
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(5)
                        
                        Text(song.0) // 歌曲标题
                            .font(.body)
                            .padding(.leading, 10)
                    }
                    .padding(.vertical, 5)
                }
            }
            .padding()
            
            Spacer() // 用于在底部留出一些空间
        }
    }
}

// 预览
struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
