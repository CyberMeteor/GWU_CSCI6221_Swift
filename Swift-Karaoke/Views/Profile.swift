import SwiftUI

struct Profile: View {
    // 假设有五个不同的头像图片名称
    let profileImages = ["mm", "mm2", "mm3", "mm4", "mm5"]
    let userName = "Student beg for A"
    let userDescription = "Karaoke enthusiast. Love to explore new songs and share with friends."
    let topSongs = [
        ("drown", "milet_drown"),
        ("ref:rain", "aimer_ref_rain"),
        ("when christmas comes to town", "when christmas comes to town"),
        // 更多歌曲...
    ]

    var body: some View {
        VStack(alignment: .center) {
            // 头像们，水平排列
            HStack(spacing: 15) {
                ForEach(0..<profileImages.count, id: \.self) { index in
                    VStack {
                        Image(self.profileImages[index])
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        
                        Text("\(index + 1)")
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

            // 显示名为“heatmap-removebg-preview”的图片，并与时钟符号并排显示
            HStack {
                Image("heatmap-removebg-preview")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.55)
                    .padding(.horizontal)

                VStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.primary)
                        .imageScale(.large)
                    Text("256 hours listened last month")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                Spacer()
            }
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
            Image("wallpapers")
                .resizable()
                .blur(radius: 20)
                .overlay(Color.white.opacity(0.85))
                .edgesIgnoringSafeArea(.all)
        )
    }
}

// 预览部分
struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
