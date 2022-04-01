//
//  UserLibraryView.swift
//  PLAYLiST
//
//  Created by Nyilas Zsombor on 2021. 09. 30..
//

import SwiftUI

// represents every playlist the user has
struct UserLibraryView: View {
    // accessing the cholor scheme of the phone, so the app can differentiate some colors
    // based on whether or not the phone is in night mode
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var spotifyController: SpotifyController
    @EnvironmentObject var nowPlaying: Song
    @State private var isPopupOpen: Bool = false
    @State private var playlistName: String = ""

    // fetching the playlists from the CoreData context
    @FetchRequest(sortDescriptors: [])
    private var playlists: FetchedResults<Playlist>
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("User library")
                        .font(.headline)
                    Spacer()
                    Button {
                        isPopupOpen.toggle()
                    } label: {
                        Text("+")
                            .frame(width: 40, height: 20)
                            .background(colorScheme == .light ? Color.black : Color.white)
                            .foregroundColor(colorScheme == .light ? .white : .black)
                            .cornerRadius(20)
                    }
                    .sheet(isPresented: $isPopupOpen) {
                        VStack(alignment: .leading) {
                            Text("Playlist name")
                                .font(.system(size: 35))
                                .font(.headline)
                            TextField("E.g. favourites", text: $playlistName)
                            Text("Name the playlist to be created.")
                                .font(.footnote)
                                .italic()
                            HStack {
                                Spacer()
                                Button {
                                    createPlaylist()
                                    isPopupOpen.toggle()
                                } label: {
                                    Text("Create")
                                }
                                .frame(width: 55, height: 5, alignment: .center)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(20)
                                Spacer()
                            }
                            Spacer()
                        }.padding()
                    }
                }
                .padding(.horizontal)
                List {
                    // creating a navigation link for each playlist, so the playlist views can open on tap
                    ForEach(playlists, id: \.self) { playlist in
                        NavigationLink(destination: PlaylistView(playlist: playlist)
                                        .environmentObject(nowPlaying)
                                        .environmentObject(spotifyController)) {
                            HStack {
                                UserLibraryItemView(playlist: playlist)
                                // adding the delete funcionality to the context menu, which opens on long tap
                                    .contextMenu {
                                        Button {
                                            deletePlaylist(playlist: playlist)
                                        } label: {
                                            Text("Delete")
                                        }
                                    }
                            }
                        }
                    }
                }
                .navigationBarHidden(true)
                .listStyle(.plain)
            }
        }
    }
    
    // saves the coredata context
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
    // creates a playlist, and saves it into the CoreData context
    func createPlaylist() {
        let playlist = Playlist(context: viewContext)
        playlist.name = playlistName
        saveContext()
    }
    
    // deletes a playlist
    func deletePlaylist(playlist: Playlist) {
        viewContext.delete(playlist)
        saveContext()
    }
}

// ViewModel for the UserLibrary model
extension UserLibraryView {
    class ViewModel: ObservableObject {
        // publishing the UserLibrary, so if it changes, it refreshes on any view that contains it
        @Published var userLibrary: UserLibrary
        
        init(userLibrary: UserLibrary) {
            self.userLibrary = userLibrary
        }
    }
}

struct UserLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        UserLibraryView()
    }
}
