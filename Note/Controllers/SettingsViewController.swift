//
//  SettingsViewController.swift
//  Note
//
//  Created by Артём Бацанов on 10.09.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import UserNotifications
import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func addPermissions(_ sender: Any) {
        // fire test notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
            if success {
                // schedule test
                //self.scheduleTest()
            }
            else if error != nil {
                print("error occurred")
            }
        })
    }
    
    
    
    
//    func scheduleTest() {
//        let content = UNMutableNotificationContent()
//        content.title = "Hello World"
//        content.sound = .default
//        content.body = "My long body. My long body. My long body. My long body. My long body. My long body. "
//
//        let targetDate = Date().addingTimeInterval(10)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate),   repeats: false)
//
//        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
//            if error != nil {
//                print("something went wrong")
//            }
//        })
//    }
}
