//
//  SettingsViewController.swift
//  Tippy
//
//  Created by Jonathan Cheng on 9/28/16.
//  Copyright © 2016 Jonathan Cheng. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var textFieldTipA: UITextField!
    @IBOutlet weak var textFieldTipB: UITextField!
    @IBOutlet weak var textFieldTipC: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // update tip % segment controller
        if UserDefaults.isDefaultsCreated() {
            let arraySavedTipPercentages = UserDefaults.getTipPercentages()
            
            textFieldTipA.text = String(format:"%.0f", arraySavedTipPercentages[0]*100)
            textFieldTipB.text = String(format:"%.0f", arraySavedTipPercentages[1]*100)
            textFieldTipC.text = String(format:"%.0f", arraySavedTipPercentages[2]*100)
            }
            
        }
        
    @IBAction func didBeginEditingTipField(sender: AnyObject) {
//        var textField: UITextField!
//        
//        if (sender.isKindOfClass(UITextField)) {
//            textField = sender as! UITextField
//        }
    }

    @IBAction func didEndEditingTipField(sender: AnyObject) {
        print("editing end")
        UserDefaults.saveDefaults((Double(textFieldTipA.text!) ?? 0)/100,
                     doubleTipB: (Double(textFieldTipB.text!) ?? 0)/100,
                     doubleTipC: (Double(textFieldTipC.text!) ?? 0)/100)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
