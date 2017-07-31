//
//  CounterFormViewModel.swift
//  iOSTest
//
//  Created by Jesus Garcia on 7/31/17.
//  Copyright © 2017 Jesus Garcia. All rights reserved.
//

import UIKit

protocol CounterFormViewModelViewDelegate: class {
  
  func counterFormViewModelDidAddCounter(_ viewModel: CounterFormViewModel,counterDataDic:[String : [Counter?]])
  func counterFormViewModelDidFoundError(_ viewModel: CounterFormViewModel)
  
}

class CounterFormViewModel {
  
  weak var viewDelegate:CounterFormViewModelViewDelegate?
  
  func createCounter(title:String){
    CountersApi.sharedInstance.createCounters(title: title, {(counters) -> Void in
      if(counters != nil){
        let counterDataDict:[String : [Counter?]] = ["counters" : counters!]
        self.viewDelegate?.counterFormViewModelDidAddCounter(self,counterDataDic: counterDataDict)
      }
      else{
        self.viewDelegate?.counterFormViewModelDidFoundError(self)
      }
    })
  }

}
