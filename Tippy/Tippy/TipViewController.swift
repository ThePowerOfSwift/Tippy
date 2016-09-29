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
    @IBOutlet weak var tipPercentSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //if default tip % don't exist, create them & save
        if !UserDefaults.isDefaultsCreated()
        {
            UserDefaults.initDefaults()
            print("defaults created and saved")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        // load tip %
        let arrayTipPercentage = UserDefaults.getTipPercentages()
        
        // calculate tip & total
        let doubleBill = Double(billTextField.text!) ?? 0
        let doubleTip = doubleBill * arrayTipPercentage[tipPercentSegmentControl.selectedSegmentIndex]
        let doubleTotal = doubleBill + doubleTip
        // update tip & total labels
        tipLabel.text = String(format:"$%.2f", doubleTip)
        totalLabel.text = String(format:"$%.2f", doubleTotal)
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateTipAmountSegmentControlTitles()
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
}

