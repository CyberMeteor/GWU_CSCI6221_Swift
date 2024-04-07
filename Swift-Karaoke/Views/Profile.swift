import SwiftUI

struct Profile: View {
    // 假定所有图片都使用 "mm" 这个名称
    let profileImage = "mm" // 头像图片名称
    let topSongs = [
        ("Song Title 1", "mm"), // 歌曲标题和统一使用 "mm" 的专辑封面图片
        ("Song Title 2", "mm"),
        ("Song Title 3", "mm")
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
            Text("Student beg for A")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 8)
            
            // 用户描述
            Text("Karaoke enthusiast. Love to explore new songs and share with friends.")
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
                        Image(song.1) // 使用同一张图片 "mm" 作为专辑封面
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                            .shadow(radius: 3)
                        
                        Text(song.0) // 歌曲标题
                            .font(.body)
                            .padding(.leading, 10)
                        
                        Spacer()
                    }
                    .padding(.vertical, 3)
                }
            }
            .padding(.horizontal)

            Spacer() // 用于在底部留出一些空间
        }
        .background(
            Image("mm") // 背景图使用同一张 "mm" 图片
                .resizable()
                .blur(radius: 10) // 应用模糊效果
                .overlay(Color.white.opacity(0.7))
                .edgesIgnoringSafeArea(.all) // 让背景填充到安全区域以外
        )
    }
}

// 预览
struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
