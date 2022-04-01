//
//  NowPlayingView.swift
//  PLAYLiST
//
//  Created by Nyilas Zsombor on 2021. 09. 26..
//

import SwiftUI

// shows every control for the currently playing song (not yet functional)
struct NowPlayingView: View {
    @EnvironmentObject var spotifyController: SpotifyController
    
    var body: some View {
        VStack {
            Text("Playlist name")
                .font(.custom("Headline", size: 40))
                .frame(width: 360, alignment: .leading)
            Image("albumcover")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 360)
            VStack(alignment: .leading) {
                // TODO: Rolling text
                Text("Song Title").font(.system(size: 20))
                Text("Artist").font(.custom("Headline", size: 30))
            }
            .frame(width: 360, alignment: .leading)
            Spacer()
            ControllerView()
                .frame(width: 360)
                .environmentObject(spotifyController)
            Spacer()
        }
        .frame(maxWidth:360)
        .padding(.top)
        .navigationBarTitleDisplayMode(.large)
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView().environmentObject(SpotifyController())
    }
}
