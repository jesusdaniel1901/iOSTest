//
//  Counter.swift
//  iOSTest
//
//  Created by Jesus Garcia on 7/30/17.
//  Copyright © 2017 Jesus Garcia. All rights reserved.
//

import UIKit

struct Counter {
  
  let title:String
  var id:String
  var count:Int
  
  
  init(id:String,title:String,count:Int) {
    self.id = id
    self.title = title
    self.count = count
  }
  
  
  static func loadCounters() -> [Counter]{
    var counters = [Counter]()
    
    let counterOne = Counter(id:"1234", title: "Jesus",count: 1)
    let counterTwo = Counter(id:"1234",title: "Ricardo",count: 1)
    let counterThree = Counter(id:"1234",title: "Osvaldo",count: 1)
    
    
    counters.append(counterOne)
    counters.append(counterTwo)
    counters.append(counterThree)
    
    print(counters.count)
    
    return counters
  }
  
}
