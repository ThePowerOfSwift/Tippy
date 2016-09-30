//
//  UserDefaults.swift
//  Tippy
//
//  Created by Jonathan Cheng on 9/28/16.
//  Copyright © 2016 Jonathan Cheng. All rights reserved.
//

import Foundation

public class UserDefaults {
    
    static var keyUserDefaultsCreatedFlag = "DefaultsSaved"
    static var keyUserDefaultsBillAmount = "stringBillAmount"
    static var keyUserDefaultsBillAmountDate = "dateBillAmount"
    // timer for bill amount cache in seconds
    static var billAmountCacheTime = 10 * 60
    
    // set user defaults dictionary
    class func userDefaults() -> NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    
    // save defaults
    class func saveDefaults(doubleTipA:Double, doubleTipB:Double, doubleTipC:Double) {
        userDefaults().setDouble(doubleTipA, forKey: "doubleTipPercentangeA")
        userDefaults().setDouble(doubleTipB, forKey: "doubleTipPercentangeB")
        userDefaults().setDouble(doubleTipC, forKey: "doubleTipPercentangeC")
        userDefaults().setBool(true, forKey: keyUserDefaultsCreatedFlag)
        userDefaults().synchronize()
    }
    
    // initialize defaults and save
    class func initDefaults() {
        saveDefaults(0.18, doubleTipB:0.2, doubleTipC:0.25)
        userDefaults().setBool(true, forKey: keyUserDefaultsCreatedFlag)
        saveBillAmount("", dateTimestamp: NSDate())
        userDefaults().synchronize()
    }
    
    // isDefaultsCreated
    class func isDefaultsCreated() -> Bool {
        return userDefaults().boolForKey(keyUserDefaultsCreatedFlag)
    }
    
    // get saved tip percentages from user defaults dict
    class func getTipPercentages() -> Array <Double> {
        return [userDefaults().doubleForKey("doubleTipPercentangeA"),
                userDefaults().doubleForKey("doubleTipPercentangeB"),
                userDefaults().doubleForKey("doubleTipPercentangeC")]
    }
    
    // save the last bill amount and time
    class func saveBillAmount(stringBillAmount:String, dateTimestamp:NSDate) {
        userDefaults().setObject(stringBillAmount, forKey: keyUserDefaultsBillAmount)
        userDefaults().setObject(dateTimestamp, forKey: keyUserDefaultsBillAmountDate)
        userDefaults().synchronize()
    }
    
    // get the last bill amount and time
    class func getBillAmount() -> (String, NSDate) {
        return (userDefaults().objectForKey(keyUserDefaultsBillAmount) as! String, userDefaults().objectForKey(keyUserDefaultsBillAmountDate) as! NSDate)
    }
}