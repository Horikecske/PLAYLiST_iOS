//
//  YoutubeVideoView.swift
//  PLAYLiST
//
//  Created by Nyilas Zsombor on 2021. 10. 09..
//

import SwiftUI
import youtube_ios_player_helper

// conforms to UIViewRepresentable, because YTPlayerView is a UIkit UIView
struct YTWrapper : UIViewRepresentable {
    // this is needed, so the videoID is updated when the state variable is updated in the parent view
    @Binding var videoID : String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        //
    }
    
    // this is needed to update the YouTube video, when opening the sheet
    func updateVideo(_ uiView: YTPlayerView, videoID: String) {
        uiView.load(withVideoId: videoID)
    }
    
}

struct YoutubeVideoView: View {
    var body: some View {
        YTWrapper(videoID: .constant("jQtP1dD6jQ0"))
    }
}

struct YoutubeVideoView_Previews: PreviewProvider {
    static var previews: some View {
        YoutubeVideoView()
    }
}
