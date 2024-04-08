import SwiftUI

struct Profile: View {
    // 假设有五个不同的头像图片名称
    let profileImages = ["mm", "mm2", "mm3", "mm4", "mm5"]
    let userName = "Student beg for A"
    let userDescription = "Karaoke enthusiast. Love to explore new songs and share with friends."
    let topSongs = [
        ("Song Title 1", "mm"),
        ("Song Title 2", "mm"),
        ("Song Title 3", "mm"),
        // 更多歌曲...
    ]

    var body: some View {
        VStack(alignment: .center) {
            // 头像们，水平排列
            HStack(spacing: 15) { // 调整间距以避免重叠，并为每个图片和下方的数字提供足够空间
                ForEach(0..<profileImages.count, id: \.self) { index in
                    VStack {
                        Image(self.profileImages[index])
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50) // 调整尺寸以适应布局
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        
                        Text("\(index + 1)") // 在图片下方显示编号
                            .font(.caption)
                    }
                }
            }
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
            
            // 数据部分
            HStack {
                Text("Followers: 120")
                    .font(.body)
                Spacer()
                Text("Following: 75")
                    .font(.body)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)

            // 显示名为“heatmap”的图片，并将其尺寸调整为原来的50%
            Image("heatmap-removebg-preview")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.5) // 使用屏幕宽度的50%作为图片宽度
                .padding(.horizontal)
                .padding(.bottom, 20)

            // 水平滑动区域
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(topSongs, id: \.0) { song in
                        VStack {
                            Image(song.1)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                                .shadow(radius: 3)
                            
                            Text(song.0)
                                .font(.body)
                                .padding(.top, 5)
                        }
                    }
                }
                .padding(.horizontal, 10)
            }

            Spacer()
        }
        .background(
            Image("mm")
                .resizable()
                .blur(radius: 10)
                .overlay(Color.white.opacity(0.7))
                .edgesIgnoringSafeArea(.all)
        )
    }
}

// 预览
struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
