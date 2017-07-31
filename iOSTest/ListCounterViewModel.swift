//
//  ListCounterViewModel.swift
//  iOSTest
//
//  Created by Jesus Garcia on 7/31/17.
//  Copyright © 2017 Jesus Garcia. All rights reserved.
//

import UIKit

protocol ListCounterViewModelViewDelegate: class {
  func listCounterViewModelDidFinishLoading(_ viewModel: ListCounterViewModel)
  func didNotFoundCounters(_ viewModel: ListCounterViewModel) 

}

class ListCounterViewModel {
  
  weak var viewDelegate:ListCounterViewModelViewDelegate?
  
  var counters = [Counter]()
  
  
  func loadCounters(){
    CountersApi.sharedInstance.getCounters(completion: {(counters) -> Void in
      if(counters != nil ){
        self.counters = counters!
        self.viewDelegate?.listCounterViewModelDidFinishLoading(self)
      }
      else {
        self.viewDelegate?.didNotFoundCounters(self)
      }
    })
  }
  
  func changeCounter(id: String,newValue: Int,oldValue: Int,stepperTag:Int){
    CountersApi.sharedInstance.changeCounter(id: id,newValue: newValue,oldValue: oldValue,{(counters) -> Void in
      if(counters != nil ){
        self.counters[stepperTag].count = newValue
        self.viewDelegate?.listCounterViewModelDidFinishLoading(self)
      }
      else {
        self.viewDelegate?.didNotFoundCounters(self)
      }
    })
  }
  
  func getTotalCountersLabel() -> Int{
    if(counters.count == 0) {
      return 0
    }
    else {
      var total = 0
      for i in 0...counters.count-1 {
        total += counters[i].count
      }
      return total
    }
  }
  
  func deleteCounter(id:String,counterIndex:Int){
    CountersApi.sharedInstance.deleteCounters(id: id, {(counters) -> Void in
      if(counters != nil){
        self.counters.remove(at: counterIndex)
        self.viewDelegate?.listCounterViewModelDidFinishLoading(self)
      }
      else{
        self.viewDelegate?.didNotFoundCounters(self)
      }
    })
  }
  
  func updateCounterList(counters:[Counter]){
    self.counters = counters
    viewDelegate?.listCounterViewModelDidFinishLoading(self)    
  }

}
