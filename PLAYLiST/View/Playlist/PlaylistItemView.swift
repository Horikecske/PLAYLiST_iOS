//
//  PlaylistItemView.swift
//  PLAYLiST
//
//  Created by Nyilas Zsombor on 2021. 09. 29..
//

import SwiftUI
//import OpenCombine

// visually represents one item in a playlist
struct PlaylistItemView: View {
    private let item: Song
    
    var body: some View {
        HStack {
            Image("music-logo")
                .resizable()
                .frame(width: 40, height: 40)
            VStack {
                Text(item.title ?? "N/A")
                Text(item.artist ?? "N/A").font(.headline)
            }
            Spacer()
            Image(item.streamingService!)
                .resizable()
                .frame(width: 40, height: 40)
        }
        .padding(.vertical)
    }
    
    init(item: Song) {
        self.item = item
    }
}

struct PlaylistItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        PlaylistItemView(item: Song())
    }
}
