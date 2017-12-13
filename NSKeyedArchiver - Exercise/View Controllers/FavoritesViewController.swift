//
//  FavoritesViewController.swift
//  NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteList = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoriteTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getFavorite()
    }
    
    func getFavorite() {
        favoriteList = DataModel.shared.getLists()
        self.favoriteTableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let imageDVC = segue.destination as? DetailFavoriteViewController {
            imageDVC.favoriteImage = favoriteList[self.favoriteTableView.indexPathForSelectedRow!.row]
        }
    }
    
}
