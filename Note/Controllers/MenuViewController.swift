//
//  MenuViewController.swift
//  Note
//
//  Created by Артём Бацанов on 03.09.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var NoteLabel: UILabel!
    @IBOutlet weak var RemidLabel: UILabel!
    @IBOutlet weak var CompletedLabel: UILabel!
    @IBOutlet weak var NeedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        ForLabel()
    }
    
  
    
    func ForLabel() {
        
        CompletedLabel.text = String (Trash.count)
        NoteLabel.text = String (Notes.count)
    }
    
    func setupNavBar() {
         navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
         navigationController?.navigationBar.shadowImage = UIImage()
         navigationController?.navigationBar.tintColor = .white
         
     }
}
