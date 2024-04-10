import SwiftUI

struct Profile: View {
    // 假设有五个不同的头像图片名称
    let profileImages = ["mm", "milet_drown", "mm3", "mm4", "mm5"]
    let userName = "Student"
    let userDescription = "Karaoke enthusiast. Love to explore new songs and share with friends."
    let topSongs = [
        ("drown", "milet_drown"),
        ("ref:rain", "aimer_ref_rain"),
        ("Polar Express", "when christmas comes to town"),
        // 更多歌曲...
    ]
    let profilename=["mm", "milet_drown", "mm3", "mm4", "mm5"]
    @State private var showThumbUp = false

    var body: some View {
        ScrollView{
            VStack(alignment: .center) {
                // 修改头像和用户名布局
                HStack {
                    // 头像
                    Image(profileImages[0]) // 假设我们使用第一个头像
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    
                    // 用户名
                    Text(userName)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, 18) // 根据需要调整间距
                }
                .padding(.top, 30)
                .padding(.bottom, 20)
                
                // 用户描述
                /*
                 Text(userDescription)
                 .font(.body)
                 .foregroundColor(.secondary)
                 .multilineTextAlignment(.center)
                 .padding(.horizontal)
                 .padding(.bottom, 20)
                 */
                
                
                
                // 数据部分
                HStack {
                    VStack {
                        Text("300")
                            .font(.system(size: 26))
                            .fontWeight(.bold)
                        Text("Following")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack {
                        Text("3.5M")
                            .font(.system(size: 26))
                            .fontWeight(.bold)
                        Text("Followers")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack {
                        Text("20")
                            .font(.system(size: 26))
                            .fontWeight(.bold)
                        Text("Friends")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.bottom, 20)
                
                // 添加的提示信息
                Text("We hope you enjoy the app!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                // 添加的绿色按钮
                Button(action: {
                    // 显示thumb up图案，并在2秒后自动隐藏
                    withAnimation {
                        self.showThumbUp = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            self.showThumbUp = false
                        }
                    }
                }) {
                    Text("Give us a thumb-up")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 14)
                        .background(Color.green)
                        .cornerRadius(22)
                    /*.overlay(
                     Image(systemName: "hand.thumbsup")
                     .font(.title)
                     .foregroundColor(.white)
                     .offset(x: -20)
                     )
                     */
                }
                .padding(.bottom, 20)
                
                // thumb up图案显示
                if showThumbUp {
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .scaleEffect(1.5)
                        .transition(.opacity) // 可以选择不同的过渡效果
                }
                
                
                
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(profileImages.indices, id: \.self) { index in
                        HStack {
                            Image(profileImages[index]) 
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .shadow(radius: 2)
                                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            Spacer()
                            Text(profilename[index])
                                .font(.title)
                                .padding(.leading, 8)
                                .fontWeight(.bold)
                            
                        }
                    }
                }
                .padding([.leading,.trailing], 20)
                .padding(.top, 20)
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
}

// 预览部分
struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
