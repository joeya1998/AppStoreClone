//
//  SearchViewController.swift
//  AppStoreClone
//
//  Created by Joey Aberasturi on 7/15/21.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //OUTLETS
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchLabel: UILabel!
    @IBOutlet var headerView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var priceSegmentControl: UISegmentedControl!
    @IBOutlet var categoryButton: UIButton!
    
    //VARIABLES
    var apps = [App]()
    var results = [App]()
    
    var genreFilter: String?
    var freeFilter = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = UIColor.separator.cgColor
        cancelButton.isHidden = true
        
        setUpLabels()
        prefill()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    func setUpLabels() {
        //searchLabel
        searchLabel.text = "Search"
        searchLabel.font = Fonts.largeTitle
        
        //searchTextField
        searchTextField.placeholder = "Games, Apps, Stories, and More"
        searchTextField.backgroundColor = .separator
        searchTextField.font = Fonts.text
        searchTextField.setLeftView(image: UIImage(systemName: "magnifyingglass")!)
        
        //categoryButton
        categoryButton.setTitle(genreFilter ?? "All Apps", for: .normal)
    }
    
    func searchAPI(term: String) {
        
        print("Searching...")
        
        let termWithoutSpaces = term.replacingOccurrences(of: " ", with: "+")
        
        let urlString = "https://itunes.apple.com/search?entity=software&term=\(termWithoutSpaces)"
        
        if let url = NSURL(string: urlString) as URL? {

            URLSession.shared.dataTask(with: url, completionHandler: { [self] (data, response, error) -> Void in

                //check for error
                if let error = error {
                    print(error)
                }

                guard let data = data else {
                    print("error")
                    return
                }
                
                //Parse Data to create App Array
                self.parse(json: data)

            }).resume()
        } else {
            print("Can not create URL")
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
 
        do {
            let jsonApps = try decoder.decode(Apps.self, from: json)
            
            results = jsonApps.results
            apps = results
            
            //apply filters and display results
            filterResults()
            
        } catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
        }
    }
    
    
    
    func filterResults() {
    
        apps = results.filter { freeFilter ? $0.price == 0 : $0.price > 0 }
        
        if genreFilter != nil {
            apps = apps.filter { $0.genres.contains(genreFilter!) }
        }
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
            //scroll to top
            if self.tableView.numberOfSections > 0 && self.tableView.numberOfRows(inSection: 0) > 0 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            
        }
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        
        //clear text
        searchTextField.text = ""
        
        //animate
        setView(view: cancelButton, hidden: true)
        setView(view: searchLabel, hidden: false)
        
        //show suggested apps
        prefill()
        view.endEditing(true)
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        
        //reset filters
        freeFilter = true
        genreFilter = nil
        categoryButton.setTitle(genreFilter ?? "All Apps", for: .normal)
        priceSegmentControl.selectedSegmentIndex = 0
        
        searchAPI(term: searchTextField.text!)
        view.endEditing(true)
    }
    
    
    @IBAction func searchBeganEditing(_ sender: Any) {
        
        //animate
        setView(view: cancelButton, hidden: false)
        setView(view: searchLabel, hidden: true)
    }
    
    func prefill() {
        //show suggested apps
        searchAPI(term: "IBM")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AppTableViewCell
        appCell.app = apps[indexPath.row]
        appCell.setUp()
        appCell.selectionStyle = .none
        return appCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = (storyboard?.instantiateViewController(identifier: "DetailsViewController"))! as DetailsViewController
        vc.app = apps[indexPath.row]
        
        //bring over cached image for navigation bar
        if let imageFromCache = imageCache.object(forKey: apps[indexPath.row].artworkUrl512 as AnyObject) as? UIImage {
            vc.image = imageFromCache
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func priceFilterDidChange(_ sender: Any) {
        freeFilter = priceSegmentControl.selectedSegmentIndex == 0
        
        //display results
        filterResults()
    }
    
    @IBAction func chooseCategory(_ sender: Any) {
        let vc = (storyboard?.instantiateViewController(identifier: "SelectCategoryTableViewController"))! as SelectCategoryTableViewController
        
        //get list of categories
        let categories = results.map { $0.genres }.flatMap { $0 }
        
        //get count of each category
        let dict = categories.reduce(into: [String: Int](), {
            x, y in
            x[y, default: 0] += 1
        })
    
        vc.categories = dict
        vc.categoryNames = Array(Set(categories)).sorted { $0 < $1 }
        vc.presentingVC = self
        vc.selected = genreFilter
        present(vc, animated: true, completion: nil)
    }
}

