//
//  DetailFavoriteViewController.swift
//  NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class DetailFavoriteViewController: UIViewController {
    
    @IBOutlet weak var imagePicture: UIImageView!
    @IBOutlet weak var imageDetail: UITextView!
    
    var favoriteImage: Image?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
    private func loadImage() {
        if let favorite = favoriteImage {
            imageDetail.text = "User: \(favorite.user) \n Tag: \(favorite.tags) \n Like(s): \(favorite.likes) \n Comments: \(favorite.comments)"
            let setImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                self.imagePicture.image = onlineImage
            }
            
            ImageAPIClient.manager.getImage(from: favorite.webformatURL, completionHandler: setImage, errorHandler: {print($0)})
        }
    }
}
