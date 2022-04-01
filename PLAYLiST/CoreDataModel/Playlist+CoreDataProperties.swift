//
//  Playlist+CoreDataProperties.swift
//  
//
//  Created by Nyilas Zsombor on 2021. 11. 20..
//
//

import Foundation
import CoreData


extension Playlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Playlist> {
        return NSFetchRequest<Playlist>(entityName: "Playlist")
    }

    @NSManaged public var name: String?
    // URL of the cover art, currently unused
    @NSManaged public var coverArt: Data?
    @NSManaged public var songs: NSSet?
    @NSManaged public var userLibrary: UserLibrary?

}

// MARK: Generated accessors for songs
extension Playlist {

    @objc(addSongsObject:)
    @NSManaged public func addToSongs(_ value: Song)

    @objc(removeSongsObject:)
    @NSManaged public func removeFromSongs(_ value: Song)

    @objc(addSongs:)
    @NSManaged public func addToSongs(_ values: NSSet)

    @objc(removeSongs:)
    @NSManaged public func removeFromSongs(_ values: NSSet)

}
