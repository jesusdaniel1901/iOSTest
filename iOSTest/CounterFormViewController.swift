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

    override func viewDidLoad() {
        super.viewDidLoad()
      viewModel = CounterFormViewModel()
    }
  
  var viewModel: CounterFormViewModel! {
    didSet {
      oldValue?.viewDelegate = nil
      viewModel?.viewDelegate = self
    }
  }
  
  // MARK: - Actions
  @IBAction func addCounterAction(_ sender: UIButton) {
    viewModel.createCounter(title: nameCounterTextField.text!)
  }
}

// MARK: - CounterFormViewModelViewDelegate
extension CounterFormViewController : CounterFormViewModelViewDelegate {
  
  func counterFormViewModelDidAddCounter(_ viewModel: CounterFormViewModel, counterDataDic: [String : [Counter?]]) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: counterNotification), object: self,userInfo: counterDataDic)    
    self.navigationController?.popViewController(animated: true)
  }
  
  func counterFormViewModelDidFoundError(_ viewModel: CounterFormViewModel) {
    let alert = UIAlertController(title: "Oppss", message: "There was an error", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Acept", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
