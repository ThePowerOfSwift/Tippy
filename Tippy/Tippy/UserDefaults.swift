//
//  UserDefaults.swift
//  Tippy
//
//  Created by Jonathan Cheng on 9/28/16.
//  Copyright © 2016 Jonathan Cheng. All rights reserved.
//

import Foundation

public class UserDefaults {
    // set user defaults dictionary
    class func userDefaults() -> NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    
    let keyUserDefaultsCreatedFlag = "DefaultsSaved"
    
    // save defaults
    class func saveDefaults(doubleTipA:Double, doubleTipB:Double, doubleTipC:Double) {
        userDefaults().setDouble(doubleTipA, forKey: "doubleTipPercentangeA")
        userDefaults().setDouble(doubleTipB, forKey: "doubleTipPercentangeB")
        userDefaults().setDouble(doubleTipC, forKey: "doubleTipPercentangeC")
        userDefaults().setBool(true, forKey: "DefaultsSaved")
        userDefaults().synchronize()
    }
    
    // initialize defaults and save
    class func initDefaults() {
        saveDefaults(0.18, doubleTipB:0.2, doubleTipC:0.25)
        userDefaults().setBool(true, forKey: "DefaultsSaved")
        userDefaults().synchronize()
    }
    
    // isDefaultsCreated
    class func isDefaultsCreated() -> Bool {
        return userDefaults().boolForKey("DefaultsSaved")
    }
    
    // get saved tip percentages from user defaults dict
    class func getTipPercentages() -> Array <Double> {
            return [userDefaults().doubleForKey("doubleTipPercentangeA"),
                    userDefaults().doubleForKey("doubleTipPercentangeB"),
                    userDefaults().doubleForKey("doubleTipPercentangeC")]
    }
}