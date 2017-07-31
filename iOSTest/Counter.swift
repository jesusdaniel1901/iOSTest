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
  
}
