//
//  ViewController.swift
//  Tippy
//
//  Created by Jonathan Cheng on 9/28/16.
//  Copyright © 2016 Jonathan Cheng. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var billDisplayLabel: UILabel!
    @IBOutlet weak var tipPercentSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //hide bill text field (for display field)
        billTextField.backgroundColor = UIColor.clearColor()
        billTextField.borderStyle = UITextBorderStyle.None
        billTextField.textColor = UIColor.clearColor()
        
        //if default tip % don't exist, create them & save
        if !UserDefaults.isDefaultsCreated()
        {
            UserDefaults.initDefaults()
            print("defaults created and saved")
        }
        
        // plug into app lifecycle: enter background
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(saveBillAmount),
            name: UIApplicationDidEnterBackgroundNotification,
            object: nil)
        
        // plug into app lifecycle: enter background
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(restoreBillAmount),
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateTipAmountSegmentControlTitles()
        // pop out keyboard
        billTextField.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateTipAmountSegmentControlTitles()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }

    @IBAction func onTap(sender: AnyObject) {
//        view.endEditing(true)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let doubleBill = Double(billTextField.text!) ?? 0
        
        //format bill amount for display
        let stringFormattedBill = stringCurrencyStyleFromDouble(doubleBill)
        //remove trailing 0's
        
        //display the formatted bill amount
        billDisplayLabel.text = stringFormattedBill
        
        // load tip %
        let arrayTipPercentage = UserDefaults.getTipPercentages()
        
        // calculate tip & total
        let doubleTip = doubleBill * arrayTipPercentage[tipPercentSegmentControl.selectedSegmentIndex]
        let doubleTotal = doubleBill + doubleTip
        // update tip & total labels with animation
        //prep for animation
        tipLabel.alpha = 0
        totalLabel.alpha = 0
        //update labels
        tipLabel.text = stringCurrencyStyleFromDouble(doubleTip)
        totalLabel.text = stringCurrencyStyleFromDouble(doubleTotal)
        //animation
        UIView.animateWithDuration(0.5, animations: {
            self.tipLabel.alpha = 1
            self.totalLabel.alpha = 1
        })
    }

    // return formatted string in local currency style given double
    func stringCurrencyStyleFromDouble(input:Double) -> String {
        
        //correct text field currency locale
        let locale = NSLocale.currentLocale()
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: locale.localeIdentifier)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.stringFromNumber(input)!
    }
    
    func stringCurrencySymbol() -> String {
        let locale = NSLocale.currentLocale()
        return locale.objectForKey(NSLocaleCurrencySymbol) as! String
    }
    
    // update tip % segment controller
    func updateTipAmountSegmentControlTitles() {
        if UserDefaults.isDefaultsCreated() {
            let arraySavedTipPercentages = UserDefaults.getTipPercentages()
            
            for i in 0..<arraySavedTipPercentages.count {
                tipPercentSegmentControl.setTitle(String(format:"%.0f%%", arraySavedTipPercentages[i]*100), forSegmentAtIndex: i)
            }
        }
        calculateTip(self)
    }
    
    //save the bill amount to user defaults dict
    func saveBillAmount() {
        //save the bill amount & timestamp
        UserDefaults.saveBillAmount(billTextField.text!, dateTimestamp: NSDate())
    }
    
    //load bill amount from user defaults if it's within timer; otherwise clear field
    func restoreBillAmount() {
        // reload last bill amount if within timer
        let (doubleBillAmount, dateBillAmount) = UserDefaults.getBillAmount()
        
        print("time elapsed since cached", Int(-dateBillAmount.timeIntervalSinceNow))
        
        if (-Int(dateBillAmount.timeIntervalSinceNow) <= Int(UserDefaults.billAmountCacheTime)) {
            // within timer, reload cached bill amount
            billTextField.text = doubleBillAmount
        }
        else {
            // outside of timer, clear bill amount
            billTextField.text = ""
        }
        
        calculateTip(self)
    }
}

