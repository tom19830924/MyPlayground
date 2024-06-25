import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var isPlay = false
    let player = AVPlayer(url: URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/Music1/v4/ab/3e/54/ab3e546a-ceb8-0d53-5169-9f1d6d55586c/mzaf_4788478901280424198.plus.aac.p.m4a")!)
    var playBinding: Binding<Bool> {
        Binding {
            return isPlay
        } set: {
            isPlay = $0
            if isPlay {
                player.play()
            }
            else {
                player.pause()
            }
        }

    }
    var body: some View {
        VStack {
            Toggle("播放", isOn: playBinding)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
