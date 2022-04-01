//
//  Song+CoreDataProperties.swift
//  
//
//  Created by Nyilas Zsombor on 2021. 11. 20..
//
//

import Foundation
import CoreData


extension Song {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: "Song")
    }

    @NSManaged public var artist: String?
    @NSManaged public var coverArt: Data?
    // which streaming service is the track from, currently Spotify or YouTube
    @NSManaged public var streamingService: String?
    @NSManaged public var title: String?
    // the identifier, which the given streaming service uses
    // track id in case of Spotify, and video id in case of YouTube
    @NSManaged public var uri: String?
    @NSManaged public var playlist: Playlist?

}
