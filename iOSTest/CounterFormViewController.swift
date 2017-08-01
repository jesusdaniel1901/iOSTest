//
//  CounterFormViewController.swift
//  iOSTest
//
//  Created by Jesus Garcia on 7/30/17.
//  Copyright © 2017 Jesus Garcia. All rights reserved.
//

import UIKit
let counterNotification = "counterNotification"

class CounterFormViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var nameCounterTextField: UITextField!

  // MARK: - Lifecicly
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  // MARK: - Actions
  @IBAction func addCounterAction(_ sender: UIButton) {
    CountersApi.sharedInstance.createCounters(title: nameCounterTextField.text!, {(counters) -> Void in
      if(counters != nil){
        let counterDataDict:[String : [Counter?]] = ["counters" : counters!]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: counterNotification), object: self,userInfo: counterDataDict)
        
        self.navigationController?.popViewController(animated: true)
      }
      else{
        let alert = UIAlertController(title: "Oppss", message: "There was an error", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Acept", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
      
    })
  }
}
