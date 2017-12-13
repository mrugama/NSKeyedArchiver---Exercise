//
//  FavoritesViewController+Extension.swift
//  NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
import UIKit

//extension FavoritesViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 350
//    }
//}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Favorite Cell", for: indexPath) as? FavoritesTableViewCell {
            let favoriteItem = favoriteList[indexPath.row]
            cell.imageTag.text = favoriteItem.tags
            cell.imageUser.text = favoriteItem.user
            
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.imagePicture?.image = onlineImage
                cell.setNeedsLayout() //Makes the image load as soon as it's ready
            }
            let errorHandler: (Error) -> Void = {(error: Error) in
                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            ImageAPIClient.manager.getImage(from: favoriteItem.previewURL,
                                            completionHandler: completion,
                                            errorHandler: errorHandler)
            return cell
        }
        return UITableViewCell()
    }
}
