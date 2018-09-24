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
  
  @NSManaged public var text: String
  @NSManaged public var latitude: Double
  @NSManaged public var longitude: Double
  @NSManaged public var isOnEntry: Bool
  @NSManaged public var creationDate: Date
  @NSManaged public var isEnabled: Bool
}

extension Reminder {
  static var entityName: String {
    return String(describing: Reminder.self)
  }
  
  @nonobjc class func createWith(text: String, latitude: Double, longitude: Double, isOnEntry: Bool, isEnabled: Bool, in context: NSManagedObjectContext) -> Reminder {
    let reminder = NSEntityDescription.insertNewObject(forEntityName: Reminder.entityName, into: context) as! Reminder
    
    reminder.creationDate = Date()
    reminder.text = text
    reminder.latitude = latitude
    reminder.longitude = longitude
    reminder.isOnEntry = isOnEntry
    reminder.isEnabled = isEnabled
    
    return reminder
  }
  
  @nonobjc class func update(_ reminder: Reminder, withText text: String, latitude: Double, longitude: Double, isOnEntry: Bool, isEnabled: Bool, in context: NSManagedObjectContext) -> Reminder {
    
    reminder.creationDate = Date()
    reminder.text = text
    reminder.latitude = latitude
    reminder.longitude = longitude
    reminder.isOnEntry = isOnEntry
    reminder.isEnabled = isEnabled
    
    return reminder
  }
}
