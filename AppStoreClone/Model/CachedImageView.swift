//
//  CachedImageView.swift
//  AppStoreClone
//
//  Created by Joey Aberasturi on 7/16/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CachedImageView : UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingCache(urlString: String) {
        
        imageUrlString = urlString
        
        //set background image while loading
        contentMode = .scaleAspectFill
        image = UIColor.lightGray.imageWithColor()
        
        //check cache for image first
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                //cache image
                if imageToCache != nil {
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                }
                
            }
        }.resume()
                
    }
    
}
