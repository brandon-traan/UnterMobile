//
//  Location+CoreDataProperties.swift
//  Unter
//
//  Created by Brandon Tran on 22/5/18.
//  Copyright © 2018 Brandon Tran. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var latitude: NSDecimalNumber?
    @NSManaged public var longitude: NSDecimalNumber?
    @NSManaged public var location: Vehicles?

}
