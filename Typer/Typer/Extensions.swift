//
//  Extensions.swift
//  FastFingers
//
//  Created by Wendel Silva on 19/08/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    func removeAllSpace() -> String {
        return self.replace(" ", replacement: "")
    }
    
    func toNumber() -> NSNumber {
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle;
        if let number = formatter.numberFromString(self) {
            return number
        } else {
            return NSNumber(integer: 0)
        }
    }
    
    mutating func withZeroInLeft(size: Int) -> String {
        
        for _ in 1...size {
            self = "0" + self
        }
        return self
    }
}

extension NSTimeInterval {
    
    func timeToString() -> String {
        
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        let fraction = Int((self - Double(seconds)) * 100.0)
        
        return String(format: "%02d:%02d:%02d:%02d", hours, minutes, seconds, Double(fraction) == (self * 100.0) ? 0 : fraction)
    }
    
    func timeToStringByMinute() -> String {
        
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        let fraction = Int((self - Double(seconds)) * 100.0)
        
        return String(format: "%02d:%02d:%02d", minutes, seconds, Double(fraction) == (self * 100.0) ? 0 : fraction)
    }
}