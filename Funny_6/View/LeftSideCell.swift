//
//  LeftSideCell.swift
//  Funny_6
//
//  Created by Trần Khánh Lâm on 5/7/19.
//  Copyright © 2019 FriendlyFriend. All rights reserved.
//

import UIKit

class LeftSideCell: UITableViewCell {

    @IBOutlet weak var imgTopic: UIImageView!
    @IBOutlet weak var titleTopic: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func loadInfo(topic: Topic) {
        titleTopic.text = topic.name
        imgTopic.image = UIImage(named: "\(topic.imgName)")
        imgTopic.layer.cornerRadius = 25
    }
}
