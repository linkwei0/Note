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
    
    @IBOutlet weak var clearTrash: UIButton!
    @IBOutlet weak var clearNotes: UIButton!
    @IBOutlet weak var clearTargets: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addPermissions(_ sender: Any) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
            if success {
            }
            else if error != nil {
                print("error occurred")
            }
        })
    }
    
    @IBAction func removeAllNotes() {
        let alertController = UIAlertController(title: "Очистить корзину?", message: nil, preferredStyle: .alert)
        
        let alertAction1 = UIAlertAction(title: "Отмена", style: .default) { (alert) in
            
        }
        
        let alertAction2 = UIAlertAction(title: "Очистить", style: .cancel) { (alert) in
            Trash.removeAll()
        }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        DispatchQueue.main.async {
            alertController.view.accessibilityIdentifier = "successAlertNotes"
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func removeAllTargets() {
        let alertController = UIAlertController(title: "Удалить все цели?", message: nil, preferredStyle: .alert)
        
        let alertAction1 = UIAlertAction(title: "Отмена", style: .default) { (alert) in
            
        }
        
        let alertAction2 = UIAlertAction(title: "Удалить", style: .cancel) { (alert) in
            Targets.removeAll()
        }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        DispatchQueue.main.async {
            alertController.view.accessibilityIdentifier = "successAlertTargets"
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func removeAllTrash() {
        let alertController = UIAlertController(title: "Удалить все заметки?", message: nil, preferredStyle: .alert)
        
        
        let alertAction1 = UIAlertAction(title: "Отмена", style: .default) { (alert) in
            
        }
        
        let alertAction2 = UIAlertAction(title: "Удалить", style: .cancel) { (alert) in
            Notes.removeAll()
        }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        DispatchQueue.main.async {
            alertController.view.accessibilityIdentifier = "successAlertTrash"
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
