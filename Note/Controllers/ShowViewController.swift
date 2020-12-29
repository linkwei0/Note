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
    @IBOutlet var addRemider: UIButton!

    public var completion: ((String, String, Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        bodyField.delegate = self
        datePicker.locale = Locale(identifier: "RU_ru")
        titleField.attributedPlaceholder = NSAttributedString(string: "Введите заголовок",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        bodyField.attributedPlaceholder = NSAttributedString(string: "Введите заголовок",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(pushSave))
    }

    @IBAction func pushSaveButton(_ sender: Any) {
        print("DEBUG: Was click")
        if let titleText = titleField.text, !titleText.isEmpty,
            let bodyText = bodyField.text, !bodyText.isEmpty {

            let targetDate = datePicker.date

            completion?(titleText, bodyText, targetDate)

        }
    }
    
    @objc func pushSave() {
            if let titleText = titleField.text, !titleText.isEmpty,
                let bodyText = bodyField.text, !bodyText.isEmpty {

                let targetDate = datePicker.date
                print("DEBUG: \(targetDate)")

                completion?(titleText, bodyText, targetDate)

            }
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }

    }

