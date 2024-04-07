import SwiftUI

struct Profile: View {
    let profileImage = "profilePlaceholder" // 请确保你的Assets中有这张图片
    let userName = "Student beg for A"
    let userDescription = "Karaoke enthusiast. Love to explore new songs and share with friends."
    let topSongs = [
        ("Song Title 1", "albumCover1"), // 替换成你的歌曲标题和专辑封面图片名称
        ("Song Title 2", "albumCover2"),
        ("Song Title 3", "albumCover3")
    ]

    var body: some View {
        VStack(alignment: .center) {
            // 头像
            Image(profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .padding(.top, 20)

            // 用户名
            Text(userName)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 8)
            
            // 用户描述
            Text(userDescription)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 20)

            // 最多听歌曲的排名和专辑封面
            VStack(alignment: .leading) {
                Text("Top Songs")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                ForEach(topSongs, id: \.0) { song in
                    HStack {
                        Image(song.1) // 专辑封面图片
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                            .shadow(radius: 3)
                        
                        Text(song.0) // 歌曲标题
                            .font(.body)
                            .padding(.leading, 10)
                        
                        Spacer() // 保证HStack内的内容靠左对齐
                    }
                    .padding(.vertical, 3)
                }
            }
            .padding(.horizontal)

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
