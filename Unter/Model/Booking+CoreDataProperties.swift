//
//  Booking+CoreDataProperties.swift
//  Unter
//
//  Created by Brandon Tran on 22/5/18.
//  Copyright © 2018 Brandon Tran. All rights reserved.
//
//

import Foundation
import CoreData


extension Booking {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Booking> {
        return NSFetchRequest<Booking>(entityName: "Booking")
    }

    @NSManaged public var car_make: String?
    @NSManaged public var car_model: String?
    @NSManaged public var customer_name: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var customer: Users?
    @NSManaged public var vehicle: Vehicles?

}
