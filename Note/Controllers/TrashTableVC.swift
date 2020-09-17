//
//  TrashTableVC.swift
//  Note
//
//  Created by Артём Бацанов on 02.09.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import UIKit

class TrashTableVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        tableView.tableFooterView = UIView()
    }
    
    
    @IBAction func RestoreNote(_ sender: Any) {
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
    }
    
    func TrueFalse(indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Удалить заметку. Данное действие необратимо", message: nil, preferredStyle: .alert)
        
        let alertAction1 = UIAlertAction(title: "Отменить", style: .default) { (alert) in
            
        }
        
        let alertAction2 = UIAlertAction(title: "Ок", style: .cancel) { (alert) in
            
            removeItemTrash(at: indexPath.row)
            self.dismiss(animated: true, completion: nil)
            self.tableView.reloadData()
        }
        
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Trash.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          let degree: Double = 90
          let rotationAngle = CGFloat(degree * .pi / 180)
          let rotationTransform = CATransform3DMakeRotation(rotationAngle, 1, 0, 0)
          cell.layer.transform = rotationTransform
          
          UIView.animate(withDuration: 1, delay: 0.2 * Double(indexPath.row), options: .curveEaseInOut, animations: {
              cell.layer.transform = CATransform3DIdentity
          })
      }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = UIColor.darkGray
        
        let currentItem = Trash[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            TrueFalse(indexPath: indexPath)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
}
