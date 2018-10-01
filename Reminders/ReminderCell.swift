//
//  ReminderCell.swift
//  Reminders
//
//  Created by Michele Mola on 20/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit

class ReminderCell: UITableViewCell {
  static let reuseIdentifier = String(describing: ReminderCell.self)
  
  @IBOutlet weak var messageLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configureCell(withReminder reminder: Reminder) {
    messageLabel.text = reminder.text
  }
  
}
