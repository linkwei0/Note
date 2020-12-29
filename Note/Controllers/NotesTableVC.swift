//
//  NotesTableVC.swift
//  Note
//
//  Created by Артём Бацанов on 29.08.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import UIKit

class NotesTableVC: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet weak var pushAddNote: UIBarButtonItem!
    
    var searchingCountry = [[String : Any]]()
    var searching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searBar()
        setupNavBar()
        tableView.tableFooterView = UIView()
    }
    
    func searBar() {
        searchBar.sizeToFit()
        searchBar.placeholder = "Поиск"
        searchBar.isTranslucent = true
        searchBar.barTintColor = UIColor.darkGray
        searchBar.backgroundColor = UIColor.darkGray
        searchBar.tintColor = UIColor.white
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    @IBAction func pushAddNote(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Заметка", message: nil, preferredStyle: .alert)
        alertController.view.accessibilityIdentifier = "newAddNote"
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Введите заметку"
        }
        
        let alertAction1 = UIAlertAction(title: "Отменить", style: .default) { (alert) in
            
        }
        
        let alertAction2 = UIAlertAction(title: "Ок", style: .cancel) { (alert) in
            let newItem = alertController.textFields![0].text
            
            if newItem == "" {
                let alertErrorEmpty = UIAlertController(title: "Ошибка", message: "Заполните поле!", preferredStyle: .alert)
                alertErrorEmpty.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    alertErrorEmpty.view.accessibilityIdentifier = "errorAlertAddNote"
                    self.present(alertErrorEmpty, animated: true, completion: nil)
                }
            }
                
            else {
                addItem(nameItem: newItem!)
            }
            self.tableView.reloadData()
        }
        
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        DispatchQueue.main.async {
            alertController.view.accessibilityIdentifier = "successAlertAddNote"
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchingCountry.count
        }
        else {
            return Notes.count
        }
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
        if searching{
            let curr = searchingCountry[indexPath.row]
            cell.textLabel?.text = curr["Name"] as? String
        } else {
            let currentItem = Notes[indexPath.row]
            cell.textLabel?.text = currentItem["Name"] as? String
        }
        cell.backgroundColor = UIColor.darkGray
        
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingCountry = Notes.filter({ (searchText) -> Bool in
            searching = true
            return true
        })
        searching = true
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "notesShow") as! NotesShowViewController
        
        let currentItem = Notes[indexPath.row]
        vc.nameLabel = currentItem["Name"] as! String
        vc.indexLabel = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentItem = Notes[indexPath.row]
            let newItem = currentItem["Name"] as! String
            addItemTrash(nameItem: newItem)
            removeItem(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}
