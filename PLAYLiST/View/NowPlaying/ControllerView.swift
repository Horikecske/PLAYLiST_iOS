//
//  ControllerView.swift
//  PLAYLiST
//
//  Created by Nyilas Zsombor on 2021. 09. 26..
//

import SwiftUI
import AVFAudio

// shows the control buttons for the NowPlayingView (not currently functional)
struct ControllerView: View {
    @EnvironmentObject var spotifyController: SpotifyController
    @Environment(\.colorScheme) var colorScheme
    @State private var isPlaying: Bool = AVAudioSession.sharedInstance().isOtherAudioPlaying
        
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    spotifyController.previousTrack()
                }) {
                    Image(systemName: "backward.end.fill")
                        .font(.system(size: 40))
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                }
                Button(action: {
                    spotifyController.playPause()
                    isPlaying = AVAudioSession.sharedInstance().isOtherAudioPlaying
                }) {
                    Image(systemName: isPlaying ? "play.circle.fill" : "pause.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                }
                Button(action: {
                    spotifyController.nextTrack()
                }) {
                    Image(systemName: "forward.end.fill")
                        .font(.system(size: 40))
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                }
            }
        }
        .foregroundColor(.black)
    }
}

struct ControllerView_Previews: PreviewProvider {
    static var previews: some View {
        ControllerView().environmentObject(SpotifyController())
    }
}
