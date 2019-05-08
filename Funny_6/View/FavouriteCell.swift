//
//  FavouriteCell.swift
//  Funny_6
//
//  Created by Trần Khánh Lâm on 5/7/19.
//  Copyright © 2019 FriendlyFriend. All rights reserved.
//

import UIKit

class FavouriteCell: UITableViewCell {
    
    @IBOutlet weak var timeFavouriteLbl: UILabel!
    @IBOutlet weak var titleStoryLbl: UILabel!
    @IBOutlet weak var demoStoryLbl: UILabel!
    @IBOutlet weak var imgTopic: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    var story: Story?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func favouiteButtonTapped(_ sender: Any) {
        changeStoryFavourite(story: story!)
    }
}
extension FavouriteCell {
    private func changeStoryFavourite(story: Story) {
        if story.favorite == 0 {
            story.favorite = 1
            favouriteButton.setImage(UIImage(named: "fill"), for: .normal)
        }else{
            story.favorite = 0
            favouriteButton.setImage(UIImage(named: "empty"), for: .normal)
        }
        FunnyDB.shared.updateStoryByFavorite(story: story)
    }
    
    func loadInfo(story: Story) {
        if story.favorite == 0 {
            favouriteButton.setImage(UIImage(named: "empty"), for: .normal)
        }else{
            favouriteButton.setImage(UIImage(named: "fill"), for: .normal)
        }
        let date = convertDate(time: story.dateFavorited)
        timeFavouriteLbl.text = date
        titleStoryLbl.text? = story.title.uppercased()
        imgTopic.image = UIImage(named: "ic_englishfun")
        let storyNotRemoveTag = (story.content)
        Helper.parseHTMLContent(storyNotRemoveTag) { (true, string) in
            DispatchQueue.main.async {
                self.demoStoryLbl.text = string
            }
        }
    }
    private func convertDate(time: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        return formatter.string(from: date as Date)
    }
}
