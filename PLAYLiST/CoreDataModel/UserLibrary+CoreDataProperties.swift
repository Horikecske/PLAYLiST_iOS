//
//  UserLibrary+CoreDataProperties.swift
//  
//
//  Created by Nyilas Zsombor on 2021. 10. 24..
//
//

import Foundation
import CoreData


extension UserLibrary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserLibrary> {
        return NSFetchRequest<UserLibrary>(entityName: "UserLibrary")
    }

    @NSManaged public var playlists: NSSet?

}

// MARK: Generated accessors for playlists
extension UserLibrary {

    @objc(addPlaylistsObject:)
    @NSManaged public func addToPlaylists(_ value: Playlist)

    @objc(removePlaylistsObject:)
    @NSManaged public func removeFromPlaylists(_ value: Playlist)

    @objc(addPlaylists:)
    @NSManaged public func addToPlaylists(_ values: NSSet)

    @objc(removePlaylists:)
    @NSManaged public func removeFromPlaylists(_ values: NSSet)

}
