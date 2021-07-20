//
//  AppTableViewCell.swift
//  AppStoreClone
//
//  Created by Joey Aberasturi on 7/16/21.
//

import UIKit

class AppTableViewCell: UITableViewCell {
    
    //OUTLETS
    @IBOutlet var logoImageView: CachedImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var screenshotOne: CachedImageView!
    @IBOutlet var screenshotTwo: CachedImageView!
    @IBOutlet var screenshotThree: CachedImageView!
    @IBOutlet var priceLabel: UILabel!
    
    //VARIABLES
    var app: App?

    func setUp() {
        setUpStyles()
        setUpData()
    }
    
    func setUpStyles() {
        title.font = Fonts.text
        subTitle.font = Fonts.subText
        subTitle.textColor = .secondaryLabel
        priceLabel.font = Fonts.subText
        priceLabel.textColor = .secondaryLabel
        
        logoImageView.cornerRadius(10)
        screenshotOne.cornerRadius(10)
        screenshotTwo.cornerRadius(10)
        screenshotThree.cornerRadius(10)
        
        //hide imageViews unless there are images for them
        screenshotOne.isHidden = true
        screenshotTwo.isHidden = true
        screenshotThree.isHidden = true
    }
    
    func setUpData() {
        title.text = app?.trackName
        subTitle.text = app?.artistName
        priceLabel.text = app!.price == 0 ? "Free" : "$\(app!.price)"
        
        logoImageView.loadImageUsingCache(urlString: app!.artworkUrl512)
        
        //create array of imageViews
        let ivArr = [screenshotOne, screenshotTwo, screenshotThree]
        
        for i in 0 ..< min(3, app!.screenshotUrls.count) {
            //show imageView
            ivArr[i]!.isHidden = false
            ivArr[i]!.loadImageUsingCache(urlString: app!.screenshotUrls[i])
        }

    }
}
