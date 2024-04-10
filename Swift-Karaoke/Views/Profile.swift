import SwiftUI

struct Profile: View {
    // 假设有五个不同的头像图片名称
    let profileImages = ["mm"]
    let userName = "Student beg for A"
    let userDescription = "Karaoke enthusiast. Love to explore new songs and share with friends."
    let topSongs = [
        ("drown", "milet_drown"),
        ("ref:rain", "aimer_ref_rain"),
        ("Polar Express", "when christmas comes to town"),
        // 更多歌曲...
    ]

    var body: some View {
        VStack(alignment: .center) {
            // 修改头像和用户名布局
            HStack {
                // 头像
                Image(profileImages[0]) // 假设我们使用第一个头像
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))

                // 用户名
                Text(userName)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 8) // 根据需要调整间距
            }
            .padding(.top, 20)
            
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
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                    Text("Following")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack {
                    Text("3.5M")
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                    Text("Followers")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack {
                    Text("20")
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                    Text("Close Friends")
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
                // 执行点赞的动作
            }) {
                HStack {
                    Image(systemName: "hand.thumbsup")
                        .font(.title)
                    Text("Give us a thumb-up")
                        .fontWeight(.bold)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(40)
            }
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
