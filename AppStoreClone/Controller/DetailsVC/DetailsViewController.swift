//
//  DetailsViewController.swift
//  AppStoreClone
//
//  Created by Joey Aberasturi on 7/18/21.
//

import UIKit

class DetailsViewController: UITableViewController {
    
    //VARIABLES
    var app: App?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
        setNavImage()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            case 0:
                let headerCell = tableView.dequeueReusableCell(withIdentifier: "detailHeader") as! DetailHeaderTableViewCell
                headerCell.app = app
                headerCell.setUp()
                headerCell.selectionStyle = .none
                return headerCell
            case 1:
                let screenshotsCell = tableView.dequeueReusableCell(withIdentifier: "detailScreenshots") as! DetailsScreenshotsTableViewCell
                screenshotsCell.app = app
                screenshotsCell.selectionStyle = .none
                return screenshotsCell
            case 2:
                let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "detailDescription") as! DetailDescriptionTableViewCell
                descriptionCell.app = app
                descriptionCell.setUp()
                descriptionCell.selectionStyle = .none
                return descriptionCell
            case 3:
                let whatsNewCell = tableView.dequeueReusableCell(withIdentifier: "detailWhatsNew") as! DetailsWhatsNewTableViewCell
                whatsNewCell.label.text = app?.releaseNotes
                whatsNewCell.setUp()
                whatsNewCell.selectionStyle = .none
                return whatsNewCell
            case 4:
                let infoCell = tableView.dequeueReusableCell(withIdentifier: "detailInfoWithHeader") as! DetailsInfoWithHeaderTableViewCell
                
                infoCell.title.text = "Seller"
                infoCell.detail.text = app?.artistName
                infoCell.detail.font = Fonts.text
                infoCell.title.font = Fonts.subText
                infoCell.title.textColor = .secondaryLabel
                infoCell.header.text = "Information"
                infoCell.header.font = Fonts.header
                
                infoCell.selectionStyle = .none
                
                return infoCell
            default:
                
                //convert to MB
                let size = round(Double(app!.fileSizeBytes)! / 1_000_000)
                
                //create dict of app information
                let dict = [("Size", "\(size) MB"), ("Version", app!.version), ("Category", app!.primaryGenreName), ("Age Rating", app!.trackContentRating)]
                
                let infoCell = tableView.dequeueReusableCell(withIdentifier: "detailInfo") as! DetailsInfoTableViewCell
                
                //startingIndexRow
                let startingIndexRow = 5

                infoCell.title.text = dict[indexPath.row - startingIndexRow].0
                infoCell.detail.text = dict[indexPath.row - startingIndexRow].1
                infoCell.detail.font = Fonts.text
                infoCell.title.font = Fonts.subText
                infoCell.title.textColor = .secondaryLabel
                
                infoCell.selectionStyle = .none
                return infoCell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        //Hide whats new cell if no release notes
        if indexPath.row == 3 {
            if app?.releaseNotes == "" {
                return 0
            }
        }
        return -1.0
    }
    
    func setNavImage() {
    
        let navHeight = navigationController!.navigationBar.frame.height
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: navHeight - 5, height: navHeight - 5))
        container.cornerRadius(10)
        
        let imageView = UIImageView(frame: container.frame)
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        
        container.addSubview(imageView)
        navigationItem.titleView = container
    }

}
