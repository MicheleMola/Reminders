//
//  MasterViewController.swift
//  Reminders
//
//  Created by Michele Mola on 20/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {
  
  let context = CoreDataStack().managedObjectContext
  
  var notificationManager = NotificationManager()
  
  lazy var dataSource: RemindersDataSource = {
    let request: NSFetchRequest<Reminder> = Reminder.fetchRequest()
    return RemindersDataSource(fetchRequest: request, managedObjectContext: self.context, tableView: self.tableView)
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = dataSource
    tableView.tableFooterView = UIView()
  }
  
  // MARK: - Segues
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        if let detailVC = segue.destination as? DetailViewController {
          let object = dataSource.reminders[indexPath.row]
          detailVC.context = context
          detailVC.reminder = object
        }
      }
    } else if segue.identifier == "addReminder" {
      if let detailVC = segue.destination as? DetailViewController {
        detailVC.context = context
      }

    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { action, indexPath in
      
      let reminder = self.dataSource.reminders[indexPath.row]
      
      self.context.delete(reminder)
      
      do {
        try self.context.save()
        self.notificationManager.currentNotificationCenter.removePendingNotificationRequests(withIdentifiers: [reminder.text])
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
    
    let doneAction = UITableViewRowAction(style: .normal, title: "Done") { action, indexPath in
      let reminder = self.dataSource.reminders[indexPath.row]
      
      let _ = Reminder.update(reminder, withText: reminder.text, latitude: reminder.latitude, longitude: reminder.longitude, isOnEntry: reminder.isOnEntry, isEnabled: false, in: self.context)
      
      do {
        try self.context.save()
      
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
    
    return [deleteAction, doneAction]
  }
  
}
