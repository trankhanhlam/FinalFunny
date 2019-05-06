//
//  FavouriteCell.swift
//  Funny_6
//
//  Created by Trần Khánh Lâm on 5/7/19.
//  Copyright © 2019 FriendlyFriend. All rights reserved.
//

import UIKit

class FavouriteCell: UITableViewCell {
    
    @IBOutlet weak var titleStoryLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func loadInfo(story: Story) {
        titleStoryLbl.text = story.title
    }
}
