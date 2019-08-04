//
//  FavouriteController.swift
//  Funny_6
//
//  Created by Trần Khánh Lâm on 5/6/19.
//  Copyright © 2019 FriendlyFriend. All rights reserved.
//

import UIKit

class FavouriteController: UIViewController {
    @IBOutlet weak var tableViewFavourite: UITableView!
    var listStoryFavourite: [Story] = []
    
    //MARK: View lyfeCycle
    override func viewWillAppear(_ animated: Bool) {
        FunnyDB.shared.getStorysFavorite { (stories) in
            self.listStoryFavourite = stories
        }
        self.tableViewFavourite.reloadData()
        self.tableViewFavourite.removeUnusedCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FavouriteController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listStoryFavourite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! FavouriteCell
        let story = listStoryFavourite[indexPath.row]
        cell.story = story
        cell.loadInfo(story: story)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = listStoryFavourite[indexPath.row]
        let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsController") as! DetailsController
        detailController.story = story
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}
