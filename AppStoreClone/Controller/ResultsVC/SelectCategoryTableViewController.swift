//
//  SelectCategoryTableViewController.swift
//  AppStoreClone
//
//  Created by Joey Aberasturi on 7/18/21.
//

import UIKit

class SelectCategoryTableViewController: UITableViewController {
    
    //VARIABLES
    var categories: [String: Int]?
    var categoryNames: [String]?
    var presentingVC: SearchViewController?
    var selected: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories!.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryCell
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            let total = categories!.values.reduce(0, +)
            cell.title.text = "All Apps (\(total))"
            cell.checkmark.isHidden = (selected != nil)
            
        } else {
            let cat = categoryNames![indexPath.row - 1]
            cell.title.text = "\(cat) (\(categories![cat]!))"
            cell.checkmark.isHidden = (cat != selected)
        }
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            selected = nil
        } else {
            selected = categoryNames![indexPath.row - 1]
        }
        
        dismiss(animated: true) {
            self.presentingVC?.genreFilter = self.selected
            self.presentingVC?.filterResults()
            self.presentingVC?.categoryButton.setTitle(self.selected ?? "All Apps", for: .normal)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43.5
    }
}

class CategoryCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var checkmark: UIImageView!
}
