//
//  DetailsScreenshotsTableViewCell.swift
//  AppStoreClone
//
//  Created by Joey Aberasturi on 7/18/21.
//

import UIKit

class DetailsScreenshotsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //OUTLETS
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var header: UILabel!
    
    //VARIABLES
    var app: App?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        header.text = "Preview"
        header.font = Fonts.header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (app?.screenshotUrls.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screenshotCell", for: indexPath) as! ScreenshotCollectionViewCell
        cell.urlString = app?.screenshotUrls[indexPath.row]
        cell.setUp()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 281, height: 500) //16:9 ratio
    }
    
}

class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    //OUTLETS
    @IBOutlet var imageView: CachedImageView!
    
    //VARIABLES
    var urlString: String?
    
    func setUp() {
        imageView.loadImageUsingCache(urlString: urlString!)
        imageView.cornerRadius(10)
    }
}
