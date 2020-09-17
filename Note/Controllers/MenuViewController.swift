//
//  MenuViewController.swift
//  Note
//
//  Created by Артём Бацанов on 03.09.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//
import RealmSwift
import UIKit

class MenuViewController: UIViewController {
    
    var CountLabel = Int()
    @IBOutlet weak var NoteLabel: UILabel!
    @IBOutlet weak var RemidLabel: UILabel!
    @IBOutlet weak var CompletedLabel: UILabel!
    @IBOutlet weak var NeedLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
    }
    
    @objc func update() {
        
        CountLabel = Notes.count
        CompletedLabel.text! = String(Trash.count)
        NoteLabel.text! = String(CountLabel)
        NeedLabel.text! = String(Targets.count)
    }
    
    func setupNavBar() {
         navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
         navigationController?.navigationBar.shadowImage = UIImage()
         navigationController?.navigationBar.tintColor = .white
         
     }
}
