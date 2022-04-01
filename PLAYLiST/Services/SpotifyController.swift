//
//  SpotifyController.swift
//  SpotifyQuickStart
//
//  Created by Nyilas Zsombor on 2021. 09. 26..
//

import SwiftUI
import Combine

class SpotifyController: NSObject, ObservableObject {
    let spotifyClientID = "your_client_id"
    let spotifyRedirectURL = URL(string:"your_redirect_url")!
    
    var accessToken: String? = nil
    
    var playURI = ""
    
    private var connectCancellable: AnyCancellable?
    
    private var disconnectCancellable: AnyCancellable?
    
    // handling the lifecycle events of the Spotify SDK
    override init() {
        super.init()
        connectCancellable = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.connect()
            }
        
        disconnectCancellable = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.disconnect()
            }

    }
        
    lazy var configuration = SPTConfiguration(
        clientID: spotifyClientID,
        redirectURL: spotifyRedirectURL
    )

    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        return appRemote
    }()
    
    var defaultCallback: SPTAppRemoteCallback {
        get {
            return { _, error in
                if let error = error {
                    print(error)
                }
            }
        }
    }
    
    // accessing the access token, when the user returns from the webview
    func setAccessToken(from url: URL) {
        let parameters = appRemote.authorizationParameters(from: url)
        
        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = accessToken
            self.accessToken = accessToken
        } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print(errorDescription)
        }
        
    }
    
    // connecting to the Spotify app remote
    func connect() {
        guard let _ = self.appRemote.connectionParameters.accessToken else {
            self.appRemote.authorizeAndPlayURI(self.playURI)
            print("connected")
            return
        }
        
        appRemote.connect()
    }
    
    // disconnecting from the Spotify app remote
    func disconnect() {
        if appRemote.isConnected {
            appRemote.disconnect()
        }
    }
    
    // plays or pauses the currently playing Spotify song
    func playPause() {
        if !appRemote.isConnected {
            appRemote.authorizeAndPlayURI(self.playURI)
            print("reconnected after lost connection")
        }
        
        appRemote.playerAPI?.getPlayerState { (result, error) -> Void in
            guard error == nil else { return }
            let playerState = result as! SPTAppRemotePlayerState
            if playerState.isPaused {
                self.appRemote.playerAPI?.resume(self.defaultCallback)
            } else {
                self.appRemote.playerAPI?.pause(self.defaultCallback)
            }
        }
    }
    
    // skips to the next track on spotify
    func nextTrack() {
        if !appRemote.isConnected {
            appRemote.authorizeAndPlayURI(self.playURI)
            print("reconnected after lost connection")
        }
        appRemote.playerAPI?.skip(toNext: defaultCallback)
    }
    
    // goes to the previous track on Spotify
    func previousTrack() {
        if !appRemote.isConnected {
            appRemote.authorizeAndPlayURI(self.playURI)
            print("reconnected after lost connection")
        }
        appRemote.playerAPI?.skip(toPrevious: defaultCallback)
    }
    
    // plays a specific Spotify track, based on the given Spotify identifier
    func playTrackByUri(uri: String) {
        if !appRemote.isConnected {
            appRemote.authorizeAndPlayURI(self.playURI)
            print("reconnected after lost connection")
        }
        appRemote.playerAPI?.play("spotify:track:" + uri, callback: defaultCallback)
    }
    
    // returns track metadata from the Spotify remote
    func getTrackInfo(uri: String) -> [String : String] {
        playTrackByUri(uri: uri)
        var information: [String : String] = [:]
        appRemote.playerAPI?.getPlayerState { (result, error) -> Void in
            guard error == nil else { return }
            let playerState = result as! SPTAppRemotePlayerState
            information["artist"] = playerState.track.artist.name
            information["title"] = playerState.track.name
        }
        return information
    }
    
}

extension SpotifyController: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.appRemote = appRemote
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("failed")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
    }
}

    extension SpotifyController: SPTAppRemotePlayerStateDelegate {
        func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
            debugPrint("Track name: %@", playerState.track.name, " ", playerState.track.uri)
        }
    }


