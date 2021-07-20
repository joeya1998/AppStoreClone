//
//  DetailDescriptionTableViewCell.swift
//  AppStoreClone
//
//  Created by Joey Aberasturi on 7/18/21.
//

import UIKit

class DetailDescriptionTableViewCell: UITableViewCell {
    
    //OUTLETS
    @IBOutlet var label: UILabel!
    
    //VARIABLES
    var app: App?

    func setUp() {
        label.text = app?.description
        label.font = Fonts.text
    }

}
