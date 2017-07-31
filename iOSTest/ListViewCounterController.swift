//
//  ViewController.swift
//  iOSTest
//
//  Created by Jesus Garcia on 7/30/17.
//  Copyright © 2017 Jesus Garcia. All rights reserved.
//

import UIKit

let cellIdentifier = "counterCell"

class ListViewCounterController: UIViewController {

  // MARK: - Outlets
  @IBOutlet weak var counterTableView: UITableView!
  @IBOutlet weak var totalCounters: UILabel!
  
  // MARK: - Properties
  var counters = [Counter]()
  
  // MARK: - LifeCicle
  override func viewDidLoad() {
    super.viewDidLoad()
    loadCounters()
    self.counterTableView.register(UINib(nibName: "CounterViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    setDelegates()
    setObservers()
    setTableViewProperties()
  }
  
  func updateCounterList(_ notification: NSNotification){
    if let counters = notification.userInfo?["counters"] as? [Counter] {
      self.counters = counters
      self.counterTableView.reloadData()
      setTotalCountersLabel()
    }
  }
  
  func setTableViewProperties(){
    self.navigationItem.title = "Counters"
  }
  
  func setDelegates (){
    counterTableView.delegate = self
    counterTableView.dataSource = self
  }
  
  func setObservers(){
    NotificationCenter.default.addObserver(self, selector: #selector(ListViewCounterController.updateCounterList(_:)), name: NSNotification.Name(rawValue: counterNotification), object: nil)
  }
  
  func setTotalCountersLabel(){
    if(counters.count == 0) {
      totalCounters.text = "Empty"
    }
    else {
      var total = 0
      for i in 0...counters.count-1 {
        total += counters[i].count
      }
      totalCounters.text = String(total)
    }
  }
  
  func loadCounters(){
    CountersApi.sharedInstance.getCounters(completion: {(counters) -> Void in
      if(counters != nil ){
        self.counters = counters!
        self.counterTableView.reloadData()
        self.setTotalCountersLabel()
      }
      else {
        let alert = UIAlertController(title: "Oppss", message: "There was an error", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Acept", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    })
  }
  
  func changeCounter(id: String,stepperTag:Int, newValue: Int,oldValue: Int){
    CountersApi.sharedInstance.changeCounter(id: id,newValue: newValue,oldValue: oldValue,{(counters) -> Void in
      if(counters != nil ){
        self.counters[stepperTag].count = newValue
        self.setTotalCountersLabel()
        self.counterTableView.reloadData()
      }
      else {
        let alert = UIAlertController(title: "Oppss", message: "There was an error", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Acept", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    })
  }
  
  func deleteCounter(id:String,counterIndex:Int){
    CountersApi.sharedInstance.deleteCounters(id: id, {(counters) -> Void in
      if(counters != nil){
        self.counters.remove(at: counterIndex)
        self.setTotalCountersLabel()
        self.counterTableView.reloadData()
      }
      else{
        let alert = UIAlertController(title: "Oppss", message: "There was an error", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Acept", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    })
  }
}

// MARK: - UITableViewDelegate
extension ListViewCounterController : UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return counters.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = counterTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
      as! CounterViewCell
    
    let counter = counters[indexPath.row]
    
    cell.counterTitleLabel.text = counter.title
    cell.countLabel.text =  String(describing: counter.count)
    cell.counterStepper.value = Double(counter.count)
    cell.delegate = self
    cell.counterStepper.tag = indexPath.row
    return cell
  }
  
}

// MARK: - UITableViewDataSource
extension ListViewCounterController : UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
  {
    if editingStyle == .delete
    {
      deleteCounter(id: counters[indexPath.row].id,counterIndex: indexPath.row)
    }
  }
}

// MARK: - StepperviewDelegate
extension ListViewCounterController : StepperViewDelegate {
  func didTapStepper(value: Int,stepperTag: Int){
    let counterId = counters[stepperTag].id
    let oldValue = counters[stepperTag].count
    changeCounter(id: counterId, stepperTag: stepperTag, newValue: value, oldValue: oldValue)
  }
}


