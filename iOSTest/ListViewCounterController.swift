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
  var viewModel: ListCounterViewModel! {
    didSet {
      oldValue?.viewDelegate = nil
      viewModel?.viewDelegate = self
    }
  }
  
  // MARK: - LifeCicle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = ListCounterViewModel()
    loadData()
    registerXibs()
    setDelegates()
    setObservers()
    setTableViewProperties()    
  }
  
  func registerXibs(){
    self.counterTableView.register(UINib(nibName: "CounterViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
  }
  
  func updateCounterList(_ notification: NSNotification){
    if let counters = notification.userInfo?["counters"] as? [Counter] {
      viewModel.updateCounterList(counters: counters)
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
  
  func loadData(){
    viewModel.loadCounters()
  }
  
  func setDefaultLabels(){
    
  }
  
  @IBAction func reloadAction(_ sender: UIBarButtonItem) {
    loadData()
  }
  
}

// MARK: - UITableViewDelegate
extension ListViewCounterController : UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.counters.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = counterTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
      as! CounterViewCell
    
    let counter = self.viewModel.counters[indexPath.row]
    
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
      viewModel.deleteCounter(id: self.viewModel.counters[indexPath.row].id, counterIndex: indexPath.row)
    }
  }
}

// MARK: - StepperviewDelegate
extension ListViewCounterController : StepperViewDelegate {
  func didTapStepper(value: Int,stepperTag: Int){
    let counterId = self.viewModel.counters[stepperTag].id
    let oldValue = self.viewModel.counters[stepperTag].count
    viewModel.changeCounter(id: counterId, newValue: value, oldValue: oldValue, stepperTag: stepperTag)
  }
}

// MARK: - ListCounterViewModelViewDelegate
extension ListViewCounterController : ListCounterViewModelViewDelegate {
  
  func listCounterViewModelDidFinishLoading(_ viewModel: ListCounterViewModel) {
    self.counterTableView.reloadData()
    let totalCounterValue = viewModel.getTotalCountersLabel()
    if(totalCounterValue == 0) {      
      totalCounters.text = "Empty"
    }
    else {
      totalCounters.text = String(totalCounterValue)
    }
  }
  
  func didNotFoundCounters(_ viewModel: ListCounterViewModel) {
    let alert = UIAlertController(title: "Oppss", message: "There was an error", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Acept", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
}


