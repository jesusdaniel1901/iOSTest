
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
  
  
  @IBOutlet weak var counterTitleLabel: UILabel!
  
  @IBOutlet weak var counterStepper: UIStepper!
  
  @IBOutlet weak var countLabel: UILabel!
  
  var delegate : StepperViewDelegate?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  @IBAction func stepperAction(_ sender: UIStepper) {
    self.delegate?.didTapStepper(value: Int(sender.value),stepperTag: counterStepper.tag)
  }
}
