//
//  SpyNavigationController.swift
//  NoteTests
//
//  Created by Артём Бацанов on 20.12.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import UIKit

class SpyNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        pushedViewController = viewController
    }
    
}
