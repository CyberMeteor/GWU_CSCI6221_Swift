//
//  MusicPlayer.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/1.
//

import SwiftUI
import AVKit
import MediaPlayer

struct MusicPlayer: View {
    let audioFileName = "Tuesday"
    
    @State private var player: AVAudioPlayer?
    
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    @State private var volume: Double = 0
    @State private var volumeRange: ClosedRange<Double> = 0...100
    @State private var volumeStep: Double = 2.0
    @State private var volumeHasChanged: Bool = false
    
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    @State private var animationContenet: Bool = false
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            ZStack {
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay(content: {
                        Rectangle()
                        Image("mm")
                            .blur(radius: 55)
                        // .opacity(animation ? 1.0)
                    })
                // .matchedGeometryEffect(id: "BGVIEW", in: animation)
                
                VStack(spacing: 15){
                    GeometryReader{
                        let size = $0.size
                        Image("mm")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    .frame(height: size.width - 50)
                    .padding(.vertical, size.height < 700 ? 10: 30)
                    PlayerView(size)
                    
                }
                .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .padding(.horizontal, 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .clipped()
            }
            .ignoresSafeArea(.container, edges: .all)
        }
        
        .onAppear(perform: setupAudio)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            updateProgress()
        }
        
    }
    
    private func setupAudio() {
        guard let url = Bundle.main.url(forResource: audioFileName, withExtension: "mp3")
        else{
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            totalTime = player?.duration ?? 0.0
        } catch {
            print("Error loading audio: \(error)")
        }
    }
    
    private func playAudio() {
        player?.play()
        isPlaying = true
    }
    
    private func stopAudio() {
        player?.pause()
        isPlaying = false
    }
    
    private func updateProgress() {
        guard let player = player else { return }
        currentTime = player.currentTime
    }
    
    private func seekAudio(to time: TimeInterval) {
        player?.currentTime = time
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
    
    private func increaseVolume() {
        guard volume < volumeRange.upperBound else { return }
        volume += volumeStep
        //        setSystemVolume(volume)
    }
    
    private func decreaseVolume() {
        guard volume > volumeRange.lowerBound else { return }
        volume -= volumeStep
        //        setSystemVolume(volume)
    }
    
    var increaseVolumeBtn: some View {
        Button {
            withAnimation {
                increaseVolume()
            }
        } label: {
            Image(systemName: "speaker.wave.3.fill")
                .tint(.white)
        }
        .opacity(volumeHasChanged ? 0.5 : 1)
        .disabled(volumeHasChanged)
    }
    
    var decreaseVolumeBtn: some View {
        Button {
            withAnimation {
                decreaseVolume()
            }
        } label: {
            Image(systemName: "speaker.fill")
                .tint(.white)
        }
        .opacity(volumeHasChanged ? 0.5 : 1)
        .disabled(volumeHasChanged)
    }
    
    private func setSystemVolume(_ value: Float) {
        let volumeView = MPVolumeView()
        if let view = volumeView.subviews.first as? UISlider {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                view.value = value
            }
        }
    }
    
    @ViewBuilder
    func PlayerView(_ mainSize: CGSize) -> some View {
        GeometryReader {
            let size = $0.size
            let spacing = size.height * 0.04
            
            VStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    HStack(alignment: .center, spacing: 15){
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Tuesday Night")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                            Text("Tony's Relaxation")
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
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
                    
                    Slider(value: Binding(get: {
                        currentTime
                    }, set: { newValue in
                        seekAudio(to: newValue)
                    }), in: 0...totalTime)
                    .accentColor(.white)
                    
                    HStack{
                        Text(timeString(time: currentTime))
                            .foregroundStyle(.white)
                        Spacer()
                        Text(timeString(time: totalTime))
                            .foregroundStyle(.white)
                    }
                }
                .frame(height: size.height / 2.5, alignment: .top)
                
                HStack(spacing: size.width * 0.18) {
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "backward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                    
                    Button{
                        
                    } label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .font(size.height < 300 ? .largeTitle : .system(size: 50))
                            .onTapGesture {
                                isPlaying ? stopAudio() : playAudio()
                            }
                    }
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "forward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
                VStack(spacing: spacing) {
                    
                    HStack(spacing: 15){
                        
                        decreaseVolumeBtn
                        
                        Slider(value: $volume,
                               in: volumeRange,
                               step: volumeStep) { volumeHasChanged in
                            self.volumeHasChanged = volumeHasChanged
//                               setSystemVolume(volume)
                        }
                               .accentColor(.white)
                        
                        increaseVolumeBtn
                    }
                    
                    
                    HStack(alignment: .top, spacing: size.width * 0.18){
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "quote.bubble")
                                .font(.title2)
                        }
                        
                        VStack(spacing: 6){
                            Button{
                                
                            } label: {
                                Image(systemName: "airpodspro.chargingcase.wireless.fill")
                                    .font(.title2)
                            }
                            Text("6221 Airpods")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "list.bullet")
                                .font(.title2)
                        }
                        
                    }
                    .foregroundColor(.white)
                    .blendMode(.overlay)
                    .padding(.top, spacing)
                }
                .frame(height: size.height / 3, alignment: .bottom)
            }
        }
    }
}

struct MusicPlayer_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayer(expandSheet: .constant(true), animation: Namespace().wrappedValue)
            .preferredColorScheme(.dark)
    }
}

extension View {
    var deviceCornerRadius: CGFloat {
        let key = "_displayCornerRadius"
        
        if let screen = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen {
            if let cornerRadius = screen.value(forKey: key) as? CGFloat {
                return cornerRadius
            }
            return 0
        }
        return 0
    }
}

