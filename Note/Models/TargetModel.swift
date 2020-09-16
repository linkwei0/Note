//
//  TargetModel.swift
//  Note
//
//  Created by Артём Бацанов on 17.09.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import Foundation

var Targets: [[String: Any]] {
    set{
        UserDefaults.standard.set(newValue, forKey: "TargetsDataKey")
        UserDefaults.standard.synchronize()
    }
    get{
        if let array = UserDefaults.standard.array(forKey: "TargetsDataKey") as? [[String: Any]]{
            return array
        }
        else{
            return []
        }
    }
}

func addTarget(nameItem: String, isCompleted: Bool = false){
    Targets.append(["Name": nameItem, "isCompleted": isCompleted])
}

func moveItem(fromIndex: Int, toIndex: Int){
    let from = Targets[fromIndex]
    Targets.remove(at: fromIndex)
    Targets.insert(from, at: toIndex)
}

func changeState(at item: Int) -> Bool{
    Targets[item]["isCompleted"] = !(Targets[item]["isCompleted"] as! Bool)
    return Targets[item]["isCompleted"] as! Bool
}

func removeTarget(at index: Int){
    Targets.remove(at: index)
}
