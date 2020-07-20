//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichDataSource {
    func saveSandwich(_: SandwichCoreData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
    
  let defaults = UserDefaults.standard
  var previousIndex = 0
  
  private var filtered = [SandwichCoreData]()
 
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
  
    
  let searchController = UISearchController(searchResultsController: nil)
  var sandwiches = [SandwichData]() //to migrate data from json file
  
  var cdSandwiches = [SandwichCoreData]()
    
  var filteredSandwiches = [SandwichCoreData]()
    
  var sauceAmounts = [SauceAmountData]()
    
  required init?(coder: NSCoder) {
    super.init(coder: coder)
 
    print(FileManager.default.urls(for:.documentDirectory, in: .userDomainMask))
    
    if let isAppAlreadyLaunchedOnce = defaults.string(forKey:"isAppAlreadyLaunchedOnce"){
        print("app already launched: \(isAppAlreadyLaunchedOnce)")
    
     // if not first run
       fetchSauceAmountData()
        if (sauceAmounts.count != 3){
        //make sure you create again
            dataMoveSauceAmountData()
            fetchSauceAmountData()
        }
       fetchSandwiches()
        
    } else {
    //only on first run
        defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
        print("App launched first time")
    loadSandwiches()  // load sandwiches of [SandwichData] from JSON file
    dataMoveSauceAmountData() // creates 3 SauceAmountData instances for each type
                             //and moves it to database
    fetchSauceAmountData()  // loads sauceAmounts of [SauceAmountData]
    seedDataMoveSandwiches() //moves sandwiches array to core data
    fetchSandwiches() // load cdSandwiches array from core data
    }
  }

    func dataMoveSauceAmountData(){
        //Save 3 records of SauceAmountData instances
        let tooMuchAmount = SauceAmountData(entity:SauceAmountData.entity(),insertInto:context)
        tooMuchAmount.sauceAmount = .tooMuch
        print("sauce amount raw value: \(tooMuchAmount.sauceAmountString!)")
        appDelegate.saveContext()
        let anyAmount = SauceAmountData(entity:SauceAmountData.entity(),insertInto:context)
        anyAmount.sauceAmount = .any
        print("sauce amount raw value: \(anyAmount.sauceAmountString!)")
        appDelegate.saveContext()
        
        let noneAmount = SauceAmountData(entity:SauceAmountData.entity(),insertInto:context)
        noneAmount.sauceAmount = .none
        print("sauce amount raw value: \(noneAmount.sauceAmountString!)")
        appDelegate.saveContext()
    }
    func fetchSauceAmountData(){
        // loads sauceAmounts array of [SauceAmountData] from core data
        
            let request = SauceAmountData.fetchRequest() as NSFetchRequest<SauceAmountData>
            
            do {
               sauceAmounts = try context.fetch(request)
                
            } catch let error as NSError{
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            for sauceAmount in sauceAmounts {
                print("sauceAmount retrieved: \(sauceAmount.sauceAmountString!)")
            }
            
        }
    func seedDataMoveSandwiches(){
        //use old sandwiches array to seed core data
        
        for sandwich in sandwiches{
            let  aSandwich = SandwichCoreData(entity: SandwichCoreData.entity(),insertInto:context)
            aSandwich.name = sandwich.name
            aSandwich.imageName = sandwich.imageName
            aSandwich.sauceAmount = sandwich.sauceAmount.rawValue
           //I added a string field .sauceAmount in SandwichCoreData
            
           /* let aSauciness = SauceAmountData()
            aSauciness.sauceAmount = sandwich.sauceAmount
            aSandwich.sauciness = aSauciness
 */
            if (sandwich.sauceAmount.rawValue == "Too Much"){
                aSandwich.sauciness = sauceAmounts[0]
             //   sauceAmounts[0].addToFoodItem(aSandwich)
                //didn't know that this happened automatically
                //w inverse relationship
            } else {
                aSandwich.sauciness = sauceAmounts[2]
             //   sauceAmounts[2].addToFoodItem(aSandwich)
            }
            
            appDelegate.saveContext()
        }
        
    }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    previousIndex = (defaults.object(forKey: "index")) as? Int ?? 0
        
     print("getting previous index: previousIndex from viewDidLoad:\(previousIndex)")
    
    searchController.searchBar.selectedScopeButtonIndex = previousIndex
        
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
    
    navigationItem.rightBarButtonItem = addButton
    
    // Setup Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Filter Sandwiches"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
    searchController.searchBar.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
    
  func generateData() -> [SandwichData]? {
        //fetch from JSON file into [SandwichData]
    
        if let filePath = Bundle.main.path(forResource: "sandwiches", ofType: "json") {
            let fileURL = URL(fileURLWithPath: filePath)
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([SandwichData].self, from: data)
                return decodedData
            } catch let error {
                print("Error in parsing \(error.localizedDescription)")
            }
        }
        return nil
    }//function
    
  func loadSandwiches() {
    if  let sandwichArray = generateData()
    {
        sandwiches.append(contentsOf: sandwichArray)
    }
    
  }
    func fetchSandwiches(){
        let request = SandwichCoreData.fetchRequest()
                     as NSFetchRequest<SandwichCoreData>
                 //  fetchedRC = NSFetchedResultsController(fetchRequest:request, managedObjectContext: context, sectionNameKeyPath: )
                   
                   do {
                      cdSandwiches = try context.fetch(request)
                       
                   } catch let error as NSError{
                       print("Could not fetch. \(error), \(error.userInfo)")
                   }
        for sandwich in cdSandwiches{
            print("sandwiches fetched from core data - \(sandwich.name!)")
        }
    }
  func saveSandwich(_ sandwich: SandwichCoreData) {
    cdSandwiches.append(sandwich)
    
    tableView.reloadData()
  }

  @objc
  func presentAddView(_ sender: Any) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
      if segue.destination is AddSandwichViewController
      {
          let vc = segue.destination as? AddSandwichViewController
        vc?.sauceAmounts = self.sauceAmounts
      }
  }
  // MARK: - Search Controller
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
 
     func filterContentForSearchText(_ searchText: String,
     sauceAmount: SauceAmount? = nil) {
       
       let request = SandwichCoreData.fetchRequest() as NSFetchRequest<SandwichCoreData>
        
        if (sauceAmount != .any){
            if (searchText.isEmpty){
                request.predicate = NSPredicate(format: "sauceAmount MATCHES %@", sauceAmount!.rawValue)
            } else {
                request.predicate = NSPredicate(format: "sauceAmount MATCHES %@ AND  name CONTAINS[cd] %@", sauceAmount!.rawValue,searchText)
            }
        } else {
            if  (!searchText.isEmpty){
            request.predicate = NSPredicate(format:"name CONTAINS[cd] %@",searchText)
            }
        }
        let sort = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
      
        do {
            filteredSandwiches = try context.fetch(request)
        } catch{
            print("Error loading sandwiches \(error)")
        }
        
 
      tableView.reloadData()
     }
     
     
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering =
      searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive &&
      (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredSandwiches.count : cdSandwiches.count
  }
    /*
    func reloadCdSandwiches(){
    let request = SandwichCoreData.fetchRequest() as NSFetchRequest<SandwichCoreData>
     let sort = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
       request.sortDescriptors = [sort]
     
       do {
           cdSandwiches = try context.fetch(request)
       } catch{
           print("Error loading sandwiches \(error)")
       }
    }
 */
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
      else { return UITableViewCell() }
    
    let sandwich = isFiltering ?
      filteredSandwiches[indexPath.row] :
      cdSandwiches[indexPath.row]
    //instead of cdSandwiches fetch from core data

    cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName!)
    cell.nameLabel.text = sandwich.name
  //  cell.sauceLabel.text = sandwich.sauceAmount.description
    cell.sauceLabel.text = sandwich.sauciness?.sauceAmountString
    return cell
  }
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
    
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
    
 
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![selectedScope])
    
    defaults.set(selectedScope, forKey:"index")
    searchBar.selectedScopeButtonIndex = selectedScope
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
    
  }
}


