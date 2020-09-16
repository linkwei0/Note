//
//  ShowViewController.swift
//  Note
//
//  Created by Артём Бацанов on 07.09.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

//import RealmSwift
import UIKit

class ShowViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!

    public var completion: ((String, String, Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        bodyField.delegate = self
        datePicker.locale = Locale(identifier: "RU_ru")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(pushSave))
    }

    @objc func pushSave() {
            if let titleText = titleField.text, !titleText.isEmpty,
                let bodyText = bodyField.text, !bodyText.isEmpty {

                let targetDate = datePicker.date

                completion?(titleText, bodyText, targetDate)

            }
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }

    }

