//
//  SearchView.swift
//  PLAYLiST
//
//  Created by Nyilas Zsombor on 2021. 10. 12..
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var spotifyController: SpotifyController
    @State private var uri: String = ""
    @State private var source: String = "Spotify"
    @State private var isPlaylistSelectorOpen: Bool = false
    @State private var artistName = ""
    @State private var songTitle = ""
    
    // fetching the playlists from the CoreData context
    @FetchRequest(sortDescriptors: [])
    private var playlists: FetchedResults<Playlist>
    
    var body: some View {
        VStack {
            Text("Search").font(.headline)
            Picker(selection: $source, label: Text("Source")) {
                Text("Spotify").tag("Spotify")
                Text("YouTube").tag("YouTube")
            }
            .pickerStyle(.segmented)
            TextField("Spotify URI or YouTube video code", text: $uri)
            Text("For Spotify use the unique track identifier, for YouTube use the YouTube identifier.")
                .font(.footnote)
                .italic()
            Button("Add to playlist") {
                isPlaylistSelectorOpen.toggle()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(20)
            .sheet(isPresented: $isPlaylistSelectorOpen) {
                VStack {
                    TextField("Artist name", text: $artistName)
                        .padding()
                    TextField("Song title", text: $songTitle)
                        .padding()
                    Spacer()
                    Text("Name the track and the artist, then choose the playlist, you wish to add the track to.")
                        .font(.footnote)
                        .italic()
                    List {
                        ForEach(playlists, id: \.self) { playlist in
                            UserLibraryItemView(playlist: playlist)
                                .onTapGesture {
                                    // creating the song and closing the modal sheet
                                    createSong(playlist: playlist)
                                    isPlaylistSelectorOpen.toggle()
                                }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            Spacer() 
        }
    }
    
    // creating a song and storing it in the CoreData context
    func createSong(playlist: Playlist) {
        let song = Song(context: viewContext)
        song.uri = uri
        song.artist = artistName
        song.title = songTitle
        song.streamingService = source
        playlist.addToSongs(song)
        saveContext()
    }
    
    // saving the CoreData context
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
