//
//  TrashModel.swift
//  Note
//
//  Created by Артём Бацанов on 02.09.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import Foundation

var Trash: [[String: Any]] {
    set{
        UserDefaults.standard.set(newValue, forKey: "TrashKey")
        UserDefaults.standard.synchronize()
    }
    get{
        if let array = UserDefaults.standard.array(forKey: "TrashKey") as? [[String: Any]]{
            return array
        }
        else{
            return []
        }
    }
}

func addItemTrash(nameItem: String){
    Trash.append(["Name": nameItem])
}

func removeItemTrash(at index: Int){
    Trash.remove(at: index)
}
