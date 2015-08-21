//
//  Util.swift
//  FastFingers
//
//  Created by Wendel Silva on 19/08/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class Util {
 
    static func alert(controller: UIViewController, texto: String) {
        let tapAlert = UIAlertController(title: "=P", message: texto, preferredStyle: .Alert)
        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
        
        controller.presentViewController(tapAlert, animated: true, completion: nil)
    }
    
    static func randonNumber(maximo: Int) -> Int {
        return Int(arc4random_uniform(UInt32(maximo)))
    }

}