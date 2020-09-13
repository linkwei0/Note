//
//  RemiderViewController.swift
//  Note
//
//  Created by Артём Бацанов on 07.09.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import RealmSwift
import UIKit

class RemiderViewController: UIViewController , UITextFieldDelegate {
    
//    @IBOutlet var textFiled: UITextField!
//    @IBOutlet var datePicker: UIDatePicker!
//    
//    private let realm = try! Realm()
//    public var completionHandler: (() -> Void)?
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        datePicker.locale = Locale(identifier: "ru_RU")
//        textFiled.becomeFirstResponder()
//        textFiled.delegate = self
//        datePicker.setDate(Date(), animated: true)
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(SaveBtn))
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textFiled.resignFirstResponder()
//        return true
//    }
//    
//    @objc func SaveBtn() {
//        if let text = textFiled.text, !text.isEmpty {
//            let date = datePicker.date
//            
//            realm.beginWrite()
//            
//            let newItem = ToDoListItem()
//            newItem.date = date
//            newItem.item = text
//            realm.add(newItem)
//            try! realm.commitWrite()
//            
//            completionHandler?()
//            navigationController?.popViewController(animated: true)
//        }
//    }
}

