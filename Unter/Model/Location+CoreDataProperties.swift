//
//  Location+CoreDataProperties.swift
//  Unter
//
//  Created by Brandon Tran on 23/5/18.
//  Copyright © 2018 Brandon Tran. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var location: Vehicles?

}
