//
//  ImagesViewController+Extension.swift
//  NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
import UIKit

//extension ImagesViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 350
//    }
//}

extension ImagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = imageTableView.dequeueReusableCell(withIdentifier: "Image Cell", for: indexPath) as? ImagesTableViewCell {
            let image = images[indexPath.row]
            cell.imageTag?.text = image.tags
            cell.imageUser?.text = image.user
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
            ImageAPIClient.manager.getImage(from: image.previewURL,
                                            completionHandler: completion,
                                            errorHandler: errorHandler)
            return cell
        }
        return UITableViewCell()
    }
}

extension ImagesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text ?? ""
    }
}
