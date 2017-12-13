//
//  AddFavoriteViewController.swift
//  NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class AddFavoriteViewController: UIViewController {
    
    @IBOutlet weak var imagePicture: UIImageView!
    @IBOutlet weak var imageDetail: UITextView!
    
    var favoriteImage: Image?
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
    
    @IBAction func addFavorite(_ sender: Any) {
        var titleAlert = ""
        var messageAlert = ""
        if let favorite = favoriteImage {
            if DataModel.shared.getLists().contains(where: {$0.id == favorite.id}) {
                titleAlert = "Alert"
                messageAlert = "This element already exists in your favorite"
            } else {
                DataModel.shared.addDSAItemToList(dsaItem: favorite)
                titleAlert = "Favorite"
                messageAlert = "Added to favorite"
            }
            let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            self.addButton.isEnabled = false
        }
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
    
    @IBAction func cancelButton(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
}
