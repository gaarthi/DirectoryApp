//
//  UIImageView+Extensions.swift
//  DirectoryApp
//
//  Created by Aarthi on 02/11/22.
//

import Foundation
import UIKit

extension UIImageView {
    
    func roundedImage() {
        self.layer.cornerRadius = self.bounds.size.width/2
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2.0
        self.layer.borderColor = #colorLiteral(red: 0.7711589932, green: 0.005512437318, blue: 0.01124850567, alpha: 1)
    }
    
    public func imageFromServerURL(urlString:String, placeHolderImage:UIImage) {
        if self.image == nil{
            self.image = placeHolderImage
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}
