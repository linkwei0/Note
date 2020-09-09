//
//  NotesTableVC.swift
//  Note
//
//  Created by Артём Бацанов on 29.08.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import UIKit

class NotesTableVC: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var filter = [Notes]
    
    
    //@IBOutlet weak var textNote: UINavigationItem!
    //@IBOutlet weak var textBarBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Меню", style: .plain, target: self, action: #selector(backTo))
        searBar()
        setupNavBar()
        tableView.tableFooterView = UIView()
    }
    
    func searBar() {
        searchBar.sizeToFit()
        searchBar.placeholder = "Поиск"
        searchBar.isTranslucent = true
        searchBar.barTintColor = UIColor.darkGray
        searchBar.backgroundColor = UIColor.systemGray
    }
    
    /*@objc func backTo(_ sender: Any) {
     dismiss(animated: true, completion: nil)
     }*/
    
    func setupNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    @IBAction func pushAddNote(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Заметка", message: nil, preferredStyle: .alert)
        
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
                self.present(alertErrorEmpty, animated: true, completion: nil)
            }
                
            else {
                addItem(nameItem: newItem!)
                //print("Start")
                //vc.update()
            }
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
        return Notes.count
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
        
        let currentItem = Notes[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        return cell
    }
    
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "notesShow" {
//                if let indexPath = tableView.indexPathForSelectedRow {
//                    let vc = segue.destination as! NotesShowViewController
//                    let currentItem = Notes[indexPath.row]
//                    vc.nameLabel = currentItem["Name"] as? String
//                }
//            }
//        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "notesShow") as! NotesShowViewController
        
        let currentItem = Notes[indexPath.row]
        vc.nameLabel = currentItem["Name"] as! String
        vc.indexLabel = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //let newItem = alertController.textFields![0].text
        //var a: String
        if editingStyle == .delete {
            //  addItem(nameItem: newItem!)
            let currentItem = Notes[indexPath.row]
            let newItem = currentItem["Name"] as! String
            addItemTrash(nameItem: newItem)
            removeItem(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        tableView.allowsSelection = false
    //
    //        let selectedCell = tableView.cellForRow(at: indexPath)!
    //        let VC = NotesShowViewController()
    //        performSegue(withIdentifier: "VC", sender: selectedCell)
    //        self.navigationController?.pushViewController(VC, animated: true)
    //
    //
    //
    //
    //        //if selectedCell.backgroundColor == UIColor.formulaFormColor() {
    //            //selectedCell.backgroundColor = UIColor.formulaMediumBlue()
    //           // UIView.animateWithDuration(0.5, animations: {
    //                //selectedCell.backgroundColor = UIColor.formulaFormColor()
    //           // })
    //        //} else {
    //            //selectedCell.backgroundColor = UIColor.formulaGreenColor()
    //           // UIView.animateWithDuration(0.5, animations: {
    //             //   selectedCell.backgroundColor = UIColor.formulaLightGreenColor()
    //            //})
    //        }
    
}



/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

