//
//  Notifications.swift
//  Shopping List
//
//  Created by Kenny on 12/27/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    private var date = Date()
    
    //Request permission to present notifications
    func notificationRequest() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
           (didAllow, error) in
           if !didAllow {
               print("User has declined notifications")
           }
       }
    }
    
    private func scheduleNotification() -> UNMutableNotificationContent {
        print("Scheduling")
        let content = UNMutableNotificationContent()
        content.title = "Delivery Notification"
        content.body = "Your Delivery has arrived!"
        content.sound = UNNotificationSound.default()
        //content.badge = 1
        
        return content
    }
    
    func triggerNotification(onDate date: Date) {
        self.date = date
        let notificationDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: notificationDate, repeats: false)
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: scheduleNotification(),
                                            trigger: trigger)
        notificationCenter.add(request) { (error) in
            print("request added for \(date)")
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}

