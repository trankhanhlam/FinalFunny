//
//  DetailsController.swift
//  Funny_6
//
//  Created by Trần Khánh Lâm on 5/7/19.
//  Copyright © 2019 FriendlyFriend. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {

    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    var story: Story?
    var topic: Topic?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadStory(story: Story) {
        let storyNotRemoveTag = (story.content)
        //convert HTML
        Helper.parseHTMLContent(storyNotRemoveTag) { (true, string) in
            DispatchQueue.main.async {
                self.detailsLbl.text = string
            }
        }
    }
}
