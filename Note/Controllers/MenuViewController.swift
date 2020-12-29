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
    @IBOutlet weak var pushToSettings: UIBarButtonItem!
    @IBOutlet weak var buttonNotes: UIButton!
    @IBOutlet weak var buttonRemiders: UIButton!
    @IBOutlet weak var buttonTargets: UIButton!
    @IBOutlet weak var buttonFinished: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func pushToSettings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsContoller = storyboard.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
        self.navigationController?.pushViewController(settingsContoller, animated: true)
    }
    
    @IBAction func pushToNotes(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let notesContoller = storyboard.instantiateViewController(withIdentifier: "Notes") as! NotesTableVC
        notesContoller.view.accessibilityIdentifier = "MenuViewController"
        self.navigationController?.pushViewController(notesContoller, animated: true)
    }
    
    @IBAction func pushToRemiders(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let remidersContoller = storyboard.instantiateViewController(withIdentifier: "remid") as! MainViewController
        self.navigationController?.pushViewController(remidersContoller, animated: true)
    }
    @IBAction func pushToTargets(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let targetsContoller = storyboard.instantiateViewController(withIdentifier: "Targets") as! TargetsTableVC
//        self.navigationController?.pushViewController(targetsContoller, animated: true)
    }
    
    @IBAction func pushToFinished(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsContoller = storyboard.instantiateViewController(withIdentifier: "Finished") as! TrashTableVC
        self.navigationController?.pushViewController(settingsContoller, animated: true)
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
