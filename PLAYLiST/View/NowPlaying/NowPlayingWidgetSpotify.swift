//
//  NowPlayingWidget.swift
//  PLAYLiST
//
//  Created by Nyilas Zsombor on 2021. 09. 29..
//

import SwiftUI
import AVFAudio

// the bottom widget, that contains the name and the artist of a song, and the play/pause button
struct NowPlayingWidgetSpotify: View {
    @EnvironmentObject var spotifyController: SpotifyController
    @EnvironmentObject var nowPlaying: Song
    @Environment(\.colorScheme) var colorScheme
    // accessing whether or not media is playing on the phone, used to represent the correct state of the play/pause button
    @State private var isPlaying: Bool = AVAudioSession.sharedInstance().isOtherAudioPlaying
        
    var body: some View {
        HStack {
            Image("music-logo")
                .resizable()
                .frame(width: 40, height: 40)
            VStack {
                Text(nowPlaying.title ?? "")
                Text(nowPlaying.artist ?? "").font(.headline)
            }
            Spacer()
            Button(action: {
                // play/pause functionality of the spotify controller
                spotifyController.playPause()
                // updating the play/pause button state
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

struct NowPlayingWidget_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingWidgetSpotify()
    }
}
