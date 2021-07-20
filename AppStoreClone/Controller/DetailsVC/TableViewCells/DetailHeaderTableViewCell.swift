//
//  DetailHeaderTableViewCell.swift
//  AppStoreClone
//
//  Created by Joey Aberasturi on 7/18/21.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {
    
    //OUTLETS
    @IBOutlet var logo: CachedImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var price: UILabel!
    
    //VARIABLES
    var app: App?
    
    func setUp() {
        logo.loadImageUsingCache(urlString: app!.artworkUrl512)
        title.text = app?.trackName
        subTitle.text = app?.artistName
        price.text = app!.price == 0 ? "Free" : "$\(app!.price)"
        
        addStyle()
    }
    
    func addStyle() {
        logo.cornerRadius(10)
        title.font = Fonts.text
        price.font = Fonts.text
        subTitle.font = Fonts.subText
        subTitle.textColor = .secondaryLabel
    }

}
