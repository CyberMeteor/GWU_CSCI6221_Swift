import SwiftUI
import AVKit

struct KaraokeMode: View {
    let audioFileName = "Seasons In The Sun"
    var songName: String
    var artistName: String
    @State private var lyrics: [String] = []
    @State private var lyrics_times: [TimeInterval] = []
    @State private var lyricsPointer = 0
    @State private var isVolumeSliderVisible = false
    @State private var volume: Double = 0
    @State private var isPlaylistWindowVisible = false
    @State private var player: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThickMaterial)
                .overlay(content: {
                    Rectangle()
                    Image("mm")
                        .blur(radius: 55)
                })
            VStack (spacing: 20){
                LyricsPanel()
                    .frame(width: 360, height: 521)
                ControlPanel()
                    .frame(width: 350, height: 190)
            }
        }
        .onAppear(perform: setupAudio) // Call setupAudio when the view appears
        .onAppear(perform: loadLyricsFromFile)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            updateProgress() // Update progress on timer tick
            updateLyricsPointer()
        }
        
    }
    
    
    @ViewBuilder
    func LyricsPanel() -> some View {
        ScrollView{
            VStack(alignment:.leading, spacing: 5) {
                ForEach(lyrics[lyricsPointer..<lyrics.count], id: \.self) { line in
                    Text(line)
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(line == lyrics[lyricsPointer] ? .yellow: .white)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 5)
                }
            }
        }
    }
    
    @ViewBuilder
    func ControlPanel() -> some View {
        GeometryReader {
            let size = $0.size
            let spacing = size.height * 0.04
            
            VStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    HStack(alignment: .center, spacing: 15){
                        VStack(alignment: .leading, spacing: 4) {
                            Text(songName)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                            Text(artistName)
                                .foregroundStyle(.white)
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
                        
                        Button (action:{
                            isVolumeSliderVisible.toggle()
                        }) {
                            if isVolumeSliderVisible{
                                VolumeSlider(volume: $volume)
                            } else {
                                Image(systemName: "speaker.wave.1.fill")
                                    .foregroundColor(.white)
                            }
                        }
                        .onTapGesture {
                            isVolumeSliderVisible = false
                        }
                        
                        Button(action: {
                            isPlaylistWindowVisible.toggle()
                        }) {
                            Image(systemName: "music.note.list")
                                .foregroundColor(.white)
                                .padding(12)
                        }
                        .popover(isPresented: $isPlaylistWindowVisible, arrowEdge: .bottom){
                            Text("Playlist Window")
                                .padding()
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
                }
                .frame(height: size.height / 2.5, alignment: .top)
                
            }
            
        }
        
    }
    
    private func loadLyricsFromFile(){
        guard let lyricsURL = Bundle.main.url(forResource: songName, withExtension: "lrc") else {
            print("Lyrics of \(songName) not found.")
            return
        }
        
        do {
            let lyricsText = try String(contentsOf: lyricsURL)
            let lines = lyricsText.components(separatedBy: .newlines)
            for line in lines{
                let components = line.split(separator: "]")
                guard components.count == 2 else { return }
                let timestampString = String(components[0].dropFirst())
                let lyricsString = String(components[1])
                let timestamp =  parseTimestamp(timestampString)
                lyrics.append(lyricsString)
                lyrics_times.append(timestamp)
                print(timestampString, timestamp)
            }
        } catch {
            print("Error loading lyrics: \(error)")
        }
        
    }
    
    private func parseTimestamp(_ timestampString: String) -> TimeInterval {
        // Split the timestamp string into minutes, seconds, and milliseconds
        let components = timestampString.components(separatedBy: ":")
        //print(components)
        guard components.count == 2 else { return 0 }
        
        guard let minutes = Double(components[0]),
              let seconds = Double(components[1]) else { return 0 }
        // Calculate the total time in seconds
        return TimeInterval((minutes * 60) + seconds)
    }
    
    private func highlightLyricLine(){
        
    }
    
    private func updateLyricsPointer() {
        guard lyricsPointer < lyrics_times.count && !lyrics_times.isEmpty else { return }
            
        // Check if the current time exceeds the timestamp at the current pointer index
        if lyricsPointer < lyrics_times.count - 1 && currentTime >= lyrics_times[lyricsPointer+1]{
            // Increment the pointer to the next index
            lyricsPointer += 1
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
        //print(currentTime)
    }
    
    private func seekAudio(to time: TimeInterval) {
        player?.currentTime = time
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
    
    struct VolumeSlider: View {
        @Binding var volume: Double
        
        var body: some View {
            HStack {
                Image(systemName: "speaker.fill")
                    .foregroundColor(.white)
                Slider(value: $volume, in: 0...100)
                    .accentColor(.blue)
                Image(systemName: "speaker.wave.3.fill")
                    .foregroundColor(.white)
            }
        }
    }
}
struct KaraokeMode_Previews: PreviewProvider {
    static var previews: some View {
        KaraokeMode(songName: "Seasons In The Sun", artistName: "Westlife")
            .preferredColorScheme(.dark)
    }
}

