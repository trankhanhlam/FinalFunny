//
//  StoryCell.swift
//  Funny_6
//
//  Created by Trần Khánh Lâm on 5/7/19.
//  Copyright © 2019 FriendlyFriend. All rights reserved.
//

import UIKit

class StoryCell: UITableViewCell {

    @IBOutlet weak var titleStory: UILabel!
    @IBOutlet weak var demoStory: UILabel!
    @IBOutlet weak var imgStory: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgStory.image = UIImage(named: "ic_tieulam")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func loadInfo(story: Story) {
        titleStory.text = story.title
        let storyNotRemoveTag = (story.content)
        //convert HTML
        Helper.parseHTMLContent(storyNotRemoveTag) { (true, string) in
            DispatchQueue.main.async {
                self.demoStory.text = string
            }
        }
    }
}
