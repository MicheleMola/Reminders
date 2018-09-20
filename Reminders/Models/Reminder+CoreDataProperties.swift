//
//  Reminder+CoreDataProperties.swift
//  Reminders
//
//  Created by Michele Mola on 20/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//
//

import Foundation
import CoreData

extension Reminder {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
    let request = NSFetchRequest<Reminder>(entityName: "Reminder")
    let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
    request.sortDescriptors = [sortDescriptor]
    return request
  }
  
  @NSManaged public var text: String?
  @NSManaged public var latitude: Double
  @NSManaged public var longitude: Double
  @NSManaged public var isOnEntry: Bool
  @NSManaged public var creationDate: Date
  
}
