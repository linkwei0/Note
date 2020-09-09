//
//  NotesShowViewController.swift
//  Note
//
//  Created by Артём Бацанов on 07.09.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import UIKit

class NotesShowViewController: UIViewController {
    
    
    //@IBOutlet var tableNote: UITableView!
    @IBOutlet weak var textLabel: UILabel!
    var nameLabel = String()
    var indexLabel = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(nameLabel)
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 20
        textLabel.text! = nameLabel
        textLabel.sizeToFit()
    }
    
}
