
//
//  CounterViewCell.swift
//  iOSTest
//
//  Created by Jesus Garcia on 7/30/17.
//  Copyright © 2017 Jesus Garcia. All rights reserved.
//

import UIKit

protocol StepperViewDelegate{
  
  func didTapStepper(value: Int,stepperTag: Int)
  
}

class CounterViewCell: UITableViewCell {
  
  // MARK: - Outlets
  @IBOutlet weak var counterTitleLabel: UILabel!
  
  @IBOutlet weak var counterStepper: UIStepper!
  
  @IBOutlet weak var countLabel: UILabel!
  
  // MARK: - Properties
  var delegate : StepperViewDelegate?
  
  // MARK: - Actions  
  @IBAction func stepperAction(_ sender: UIStepper) {
    self.delegate?.didTapStepper(value: Int(sender.value),stepperTag: counterStepper.tag)
  }
}
