//
//  RemindersDataSource.swift
//  Reminders
//
//  Created by Michele Mola on 20/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit
import CoreData

class RemindersDataSource: NSObject, UITableViewDataSource {
  private let tableView: UITableView
  private var fetchedResultsController: RemindersFetchedResultsController
  
  var notificationManager = NotificationManager()
  
  init(fetchRequest: NSFetchRequest<Reminder>, managedObjectContext context: NSManagedObjectContext, tableView: UITableView) {
    self.tableView = tableView
    self.fetchedResultsController = RemindersFetchedResultsController(request: fetchRequest, context: context)
    super.init()
    
    self.fetchedResultsController.delegate = self
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedResultsController.sections?[section].numberOfObjects ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let reminderCell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.reuseIdentifier, for: indexPath) as! ReminderCell
    
    let reminder = fetchedResultsController.object(at: indexPath)
    reminderCell.configureCell(withReminder: reminder)
    
    return reminderCell
  }
  
}

extension RemindersDataSource: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.reloadData()
  }
}

extension RemindersDataSource {
  var reminders: [Reminder] {
    guard let objects = fetchedResultsController.sections?.first?.objects as? [Reminder] else {
      return []
    }
    
    return objects
  }
}
