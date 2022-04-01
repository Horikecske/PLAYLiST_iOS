//
//  NowPlayingWidget.swift
//  PLAYLiST
//
//  Created by Nyilas Zsombor on 2021. 09. 29..
//

import SwiftUI
import AVFAudio

// bottom widget for the YouTube video playing (not currently functional)
struct NowPlayingWidgetYoutube: View {
    @EnvironmentObject var spotifyController: SpotifyController
    @Environment(\.colorScheme) var colorScheme
    @State private var isPlaying: Bool = AVAudioSession.sharedInstance().isOtherAudioPlaying
        
    var body: some View {
        HStack {
//            Image("albumcover")
//                .resizable()
//                .frame(width: 40, height: 40)
//            YTWrapper(videoID: <#T##String#>)
            VStack {
                Text("Song name")
                Text("Artist name").font(.headline)
            }
            Spacer()
            Button(action: {
//                spotifyController.playPause()
                isPlaying = AVAudioSession.sharedInstance().isOtherAudioPlaying
            }) {
                Image(systemName: isPlaying ? "play.circle.fill" : "pause.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(colorScheme == .light ? Color.black : Color.white)
            }
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(15)
        .onAppear {
            isPlaying = AVAudioSession.sharedInstance().isOtherAudioPlaying
        }
    }
}

struct NowPlayingWidgetYoutube_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingWidgetYoutube()
    }
}
