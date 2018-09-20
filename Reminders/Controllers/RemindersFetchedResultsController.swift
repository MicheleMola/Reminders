//
//  RemindersFetchedResultsController.swift
//  Reminders
//
//  Created by Michele Mola on 20/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import CoreData

class RemindersFetchedResultsController: NSFetchedResultsController<Reminder> {
  init(request: NSFetchRequest<Reminder>, context: NSManagedObjectContext) {
    super.init(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    
    fetch()
  }
  
  func fetch() {
    do {
      try performFetch()
    } catch {
      fatalError()
    }
  }
}
