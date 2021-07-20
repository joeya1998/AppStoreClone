//
//  DetailsWhatsNewTableViewCell.swift
//  AppStoreClone
//
//  Created by Joey Aberasturi on 7/18/21.
//

import UIKit

class DetailsWhatsNewTableViewCell: UITableViewCell {
    
    //OUTLETS
    @IBOutlet var label: UILabel!
    @IBOutlet var header: UILabel!
    
    //FUNCTIONS
    func setUp() {
        label.font = Fonts.text
        header.text = "What's New"
        header.font = Fonts.header
    }
}
