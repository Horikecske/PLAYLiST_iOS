//
//  MainTabView.swift
//  PLAYLiST
//
//  Created by Nyilas Zsombor on 2021. 09. 30..
//

import SwiftUI

struct MainTabView: View {
    
    // accessing the SpotifyController object from the environment
    @EnvironmentObject var spotifyController: SpotifyController
    // creating the initial song, with no title, artist, or uri, which is set when the application is started
    @StateObject var nowPlaying: Song = CoreDataStack.createInitialSong()
    // @State var isNowPlayingViewOpen: Bool = false
    // the CoreData context
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.openURL) var openURL
    
    // fetching the saved playlists from the CoreData context
    @FetchRequest(sortDescriptors: [])
    private var playlists: FetchedResults<Playlist>
    
    var body: some View {
        // the ZStack is needed, so that the bottom widget can be shown in every view
        ZStack(alignment: .bottomTrailing) {
            TabView {
                UserLibraryView()
                    .environmentObject(nowPlaying)
                    .environment(\.managedObjectContext, viewContext)
                    // authenticating the spotify remote
                    .onOpenURL { url in
                        spotifyController.setAccessToken(from: url)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification), perform: { _ in
                        spotifyController.connect()
                    })
                    .tabItem {
                        Image(systemName: "music.note.list")
                        Text("User library")
                    }
                SearchView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                
            }
            .environmentObject(spotifyController)
            
            // temporary fix, since iOS 15 TabBar is translucent
            .onAppear {
                if #available(iOS 15.0, *) {
                    let appearance = UITabBarAppearance()
                    UITabBar.appearance().scrollEdgeAppearance = appearance
                }
            }
            
            NowPlayingWidgetSpotify()
                .environmentObject(nowPlaying)
                .offset(y: -49)
                .padding(.horizontal, 5)
//                .onTapGesture {
//                    isNowPlayingViewOpen = true
//                }
//                .sheet(isPresented: $isNowPlayingViewOpen) {
//                    NowPlayingView()
//                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(SpotifyController())
    }
}
