//
//  CounterApi.swift
//  iOSTest
//
//  Created by Jesus Garcia on 7/30/17.
//  Copyright © 2017 Jesus Garcia. All rights reserved.
//

import UIKit

import Foundation
import Alamofire
import Unbox
import SwiftyJSON

class CountersApi {
  
  static let sharedInstance:CountersApi = CountersApi()
  
  private init() {}
  
  
  func getCounters(completion: @escaping ( _ counters: [Counter]? ) -> () ) -> Void  {
    
    var counters = [Counter]()
    
    Alamofire.request(Router.getCounters())
      .validate()
      .responseJSON { response in
        switch response.result {
        case .success(let jsonDictionary):
          let counterJson = JSON(jsonDictionary)
          for (_,subJson):(String, JSON) in counterJson {
            let counterId = subJson["id"].string!
            let counterTitle = subJson["title"].string!
            let countValue = subJson["count"].int!
            let newCount = Counter(id: counterId, title: counterTitle, count: countValue)
            counters.append(newCount)
          }
          completion(counters)
        case .failure(_):
          completion(nil)
          break
        }
    }
  }
  
  func createCounters(title:String,_ completion: @escaping ( _ counters: [Counter]? ) -> () ) -> Void  {
    
    let params: JSONDictionary = ["title": title]
    
    var counters = [Counter]()
    
    Alamofire.request(Router.createCounter(parameters: params))
      .validate()
      .responseJSON { response in
        switch response.result {
        case .success(let jsonDictionary):
          let counterJson = JSON(jsonDictionary)
          for (_,subJson):(String, JSON) in counterJson {
            let counterId = subJson["id"].string!
            let counterTitle = subJson["title"].string!
            let countValue = subJson["count"].int!
            let newCount = Counter(id: counterId, title: counterTitle, count: countValue)
            counters.append(newCount)
          }
          completion(counters)
        case .failure(_):
          completion(nil)
          break
        }
    }
  }
  
  func deleteCounters(id : String,_ completion: @escaping ( _ counters: [Counter]? ) -> () ) -> Void  {
    
    let params: JSONDictionary = ["id": id]
    
    var counters = [Counter]()
    
    Alamofire.request(Router.deleteCounter(parameters: params))
      .validate()
      .responseJSON { response in
        switch response.result {
        case .success(let jsonDictionary):
          let counterJson = JSON(jsonDictionary)
          for (_,subJson):(String, JSON) in counterJson {
            let counterId = subJson["id"].string!
            let counterTitle = subJson["title"].string!
            let countValue = subJson["count"].int!
            let newCount = Counter(id: counterId, title: counterTitle, count: countValue)
            counters.append(newCount)
          }
          completion(counters)
        case .failure(_):
          completion(nil)
          break
        }
    }
  }
  
  func changeCounter(id:String, newValue:Int , oldValue:Int ,_ completion: @escaping ( _ counters: [Counter]? ) -> () ) -> Void  {
    
    let params: JSONDictionary = ["id" : id]
    
    var counters = [Counter]()
    
    if(oldValue < newValue) {
      Alamofire.request(Router.incrementCounter(parameters: params))
        .validate()
        .responseJSON { response in
          switch response.result {
          case .success(let jsonDictionary):
            let counterJson = JSON(jsonDictionary)
            for (_,subJson):(String, JSON) in counterJson {
              let counterId = subJson["id"].string!
              let counterTitle = subJson["title"].string!
              let countValue = subJson["count"].int!
              let newCount = Counter(id: counterId, title: counterTitle, count: countValue)
              counters.append(newCount)
            }
            completion(counters)
          case .failure(_):
            completion(nil)
            break
          }
      }
    }
    else {
      Alamofire.request(Router.decrementCounter(parameters: params))
        .validate()
        .responseJSON { response in
          switch response.result {
          case .success(let jsonDictionary):
            let counterJson = JSON(jsonDictionary)
            for (_,subJson):(String, JSON) in counterJson {
              let counterId = subJson["id"].string!
              let counterTitle = subJson["title"].string!
              let countValue = subJson["count"].int!
              let newCount = Counter(id: counterId, title: counterTitle, count: countValue)
              counters.append(newCount)
            }
            completion(counters)
          case .failure(_):
            completion(nil)
            break
          }
      }
    }
  }
}
