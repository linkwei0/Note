//
//  TagetsTableVC.swift
//  Note
//
//  Created by Артём Бацанов on 17.09.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import UIKit

class TagetsTableVC: UITableViewController {
    
    @IBAction func pushEditAction(_ sender: Any) {
            tableView.setEditing(!tableView.isEditing, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.tableView.reloadData()
            }
        }
        
        @IBAction func pushAddAction(_ sender: Any) {
            
           let alertController = UIAlertController(title: "Новая цель", message: nil, preferredStyle: .alert)
            
            alertController.addTextField { (textField) in
                textField.placeholder = "Введите цель"
            }
            
            let alertAction1 = UIAlertAction(title: "Отмена", style: .default) { (alert) in
                
            }
            
            let alertAction2 = UIAlertAction(title: "Добавить", style: .cancel) { (alert) in
                let newItem = alertController.textFields![0].text
                addTarget(nameItem: newItem!)
                self.tableView.reloadData()
            }
            
            alertController.addAction(alertAction1)
            alertController.addAction(alertAction2)
            
            DispatchQueue.main.async {
                alertController.view.accessibilityIdentifier = "successAlertAddTarget"
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.tableFooterView = UIView()
            
            let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            longPressGestureRecognizer.minimumPressDuration = 1
            tableView.addGestureRecognizer(longPressGestureRecognizer)
        }
        
        @objc func handleLongPress(longPress: UILongPressGestureRecognizer){
            
            let pointOfTouch = longPress.location(in: tableView)
            let indexPath = tableView.indexPathForRow(at: pointOfTouch)
            
            if longPress.state == .began{
                if let indexPath = indexPath{
                    
                    var target = Targets[indexPath.row]["isCompleted"]
                    let alertController = UIAlertController(title: "Изменить цель", message: nil, preferredStyle: .alert)
                    
                    alertController.addTextField { (textField) in
                        textField.placeholder = "Введите цель"
                    }
                    
                    let alertAction1 = UIAlertAction(title: "Выйти", style: .default) { (alert) in
                        
                    }
                    
                    let alertAction2 = UIAlertAction(title: "Обновить", style: .cancel) { (alert) in
                        target = alertController.textFields![0].text!
                        self.tableView.reloadData()
                    }
                    
                    alertController.addAction(alertAction1)
                    alertController.addAction(alertAction2)
                    
                    present(alertController, animated: true, completion: nil)
                }
            }
        }

        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return Targets.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_target", for: indexPath)
            
            cell.backgroundColor = UIColor.darkGray
            
            let currentItem = Targets[indexPath.row]
            cell.textLabel?.text = currentItem["Name"] as? String
            
            if (currentItem["isCompleted"] as? Bool) == true{
                cell.imageView?.image = #imageLiteral(resourceName: "check")
            }
            else{
                cell.imageView?.image = #imageLiteral(resourceName: "checkNo")
            }
            
            if tableView.isEditing{
                cell.textLabel?.alpha = 0.4
                cell.imageView?.alpha = 0.4
            }
            else{
                cell.textLabel?.alpha = 1
                cell.imageView?.alpha = 1
            }
            return cell
        }

        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                removeTarget(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
            }
        }

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            if changeState(at: indexPath.row) {
                tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "check")
            }
            else{
                tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "checkNo")
            }
        }
        
        override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

            moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
            
            tableView.reloadData()
        }
        
        override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            if tableView.isEditing{
                return .none
            }
            else{
                return .delete
            }
        }
        
        override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
            return false
        }
    }
