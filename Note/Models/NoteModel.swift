//
//  NoteModel.swift
//  Note
//
//  Created by Артём Бацанов on 02.09.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import Foundation

var Notes: [[String: Any]] {
    set{
        UserDefaults.standard.set(newValue, forKey: "NoteKey")
        UserDefaults.standard.synchronize()
    }
    get{
        if let array = UserDefaults.standard.array(forKey: "NoteKey") as? [[String: Any]]{
            return array
        }
        else{
            return []
        }
    }
}

func addItem(nameItem: String){
    Notes.append(["Name": nameItem])
}
