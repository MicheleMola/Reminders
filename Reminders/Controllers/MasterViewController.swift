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
  
}
