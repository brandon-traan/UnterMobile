//
//  Vehicles+CoreDataProperties.swift
//  Unter
//
//  Created by Brandon Tran on 22/5/18.
//  Copyright © 2018 Brandon Tran. All rights reserved.
//
//

import Foundation
import CoreData


extension Vehicles {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vehicles> {
        return NSFetchRequest<Vehicles>(entityName: "Vehicles")
    }

    @NSManaged public var make: String?
    @NSManaged public var model: String?
    @NSManaged public var year: String?
    @NSManaged public var booking: Booking?
    @NSManaged public var location: Location!

}
