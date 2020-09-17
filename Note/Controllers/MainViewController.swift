//
//  MainViewController.swift
//  Note
//
//  Created by Артём Бацанов on 07.09.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

//import RealmSwift
import UIKit

//class ToDoListItem: Object {
//    @objc dynamic var item: String = ""
//    @objc dynamic var date: Date = Date()
//}

class MainViewController: UIViewController {

    @IBOutlet var table: UITableView!

    var models = [MyReminder]()

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }

    @IBAction func didTapAdd()  {
           guard let vc = storyboard?.instantiateViewController(identifier: "show") as? ShowViewController else {
               return
           }

           vc.title = "Напоминание"
           vc.navigationItem.largeTitleDisplayMode = .never
           vc.completion = { title, body, date in
               DispatchQueue.main.async {
                   self.navigationController?.popViewController(animated: true)
                   let new = MyReminder(title: title, date: date, identifier: "id_\(title)")
                   self.models.append(new)
                   self.table.reloadData()

                   let content = UNMutableNotificationContent()
                   content.title = title
                   content.sound = .default
                   content.body = body

                   let targetDate = date
                   let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                                                                             from: targetDate),
                                                               repeats: false)

                   let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
                   UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                       if error != nil {
                           print("Error")
                       }
                   })
               }
           }
           navigationController?.pushViewController(vc, animated: true)

       }

}

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


extension MainViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        let date = models[indexPath.row].date

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY"
        formatter.locale = Locale(identifier: "RU_ru")
        cell.detailTextLabel?.text = formatter.string(from: date)

        cell.textLabel?.font = UIFont(name: "Arial", size: 25)
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 22)
        return cell
    }

}


struct MyReminder {
    let title: String
    let date: Date
    let identifier: String
}

