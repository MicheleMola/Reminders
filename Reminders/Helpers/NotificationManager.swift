//
//  NotificationManager.swift
//  Reminders
//
//  Created by Michele Mola on 27/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import Foundation
import UserNotifications
import CoreLocation

struct NotificationManager {
  
  let currentNotificationCenter = UNUserNotificationCenter.current()
  
  func scheduleNotification(withReminder reminder: Reminder) {
    let center = CLLocationCoordinate2D(latitude: reminder.latitude, longitude: reminder.longitude)
    let region = CLCircularRegion(center: center, radius: 50, identifier: reminder.text)
    
    if reminder.isOnEntry {
      region.notifyOnEntry = true
      region.notifyOnExit = false
    } else {
      region.notifyOnEntry = false
      region.notifyOnExit = true
    }
    
    let trigger = UNLocationNotificationTrigger(region: region, repeats: false)

    let content = UNMutableNotificationContent()
    content.body = reminder.text
    content.sound = UNNotificationSound.default
    
    let request = UNNotificationRequest(identifier: reminder.text, content: content, trigger: trigger)
    currentNotificationCenter.add(request) { error in
      if let error = error {
        print(error)
      }
    }
  }
}
