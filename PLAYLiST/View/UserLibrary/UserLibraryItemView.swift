//
//  UserLibraryItemView.swift
//  PLAYLiST
//
//  Created by Nyilas Zsombor on 2021. 09. 30..
//

import SwiftUI

// represents on item in the list of the users library
struct UserLibraryItemView: View {
    private var playlist: Playlist
    
    var body: some View {
        HStack {
            Image("music-logo")
                .resizable()
                .frame(width:40, height: 40)
            Text(playlist.name!)
            Spacer()
        }
        .padding(.vertical)
    }
    
    init(playlist: Playlist) {
        self.playlist = playlist
    }
}

struct UserLibraryItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserLibraryItemView(playlist: Playlist())
            .environment(\.managedObjectContext, CoreDataStack.context)
    }
}
