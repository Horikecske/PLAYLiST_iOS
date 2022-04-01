//
//  PlaylistView.swift
//  PLAYLiST
//
//  Created by Nyilas Zsombor on 2021. 09. 26..
//

import SwiftUI

struct PlaylistView: View {
    @EnvironmentObject var spotifyController: SpotifyController
    @EnvironmentObject var nowPlaying: Song
    @ObservedObject private var playlist: Playlist
    @State var isYoutubePlayerOpen = false
    @State var youtubeIdentifier = ""
    
    var body: some View {
        VStack {
            Text(playlist.name ?? "Playlist")
                .font(.headline)
            List {
                let songs = playlist.songs ?? []
                // displaying every item in the playlist
                ForEach(Array(songs as Set), id: \.self) { song in
                    PlaylistItemView(item: song as! Song)
                    // starting the video or song when an item is selected
                        .onTapGesture {
                            if (song as! Song).streamingService == "Spotify" {
                                spotifyController.playTrackByUri(uri: (song as! Song).uri!)
                                nowPlaying.title = (song as! Song).title
                                nowPlaying.artist = (song as! Song).artist
                            } else if (song as! Song).streamingService == "YouTube" {
                                youtubeIdentifier = (song as! Song).uri!
                                // showing the YouTube video on a modal sheet
                                isYoutubePlayerOpen.toggle()
                            }
                        }
                }
            }
            .listStyle(.plain)
            .sheet(isPresented: $isYoutubePlayerOpen) {
                // a binding is passed, so the YTPlayer can update when a new YouTube video is selected
                YTWrapper(videoID: $youtubeIdentifier)
                    .onAppear {
                        print(youtubeIdentifier)
                    }
            }
        }
    }
    
    init(playlist: Playlist) {
        self.playlist = playlist
        
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(playlist: Playlist())
    }
}
