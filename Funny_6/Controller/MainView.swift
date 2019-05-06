//
//  MainView.swift
//  Funny_6
//
//  Created by Trần Khánh Lâm on 5/6/19.
//  Copyright © 2019 FriendlyFriend. All rights reserved.
//

import UIKit

class MainView: UITabBarController {
  
    
    var topic: Topic? {
        didSet {
            changeTopic()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    func changeTopic() {
        guard let listVC = self.viewControllers else { return }
        guard let firstNavi = listVC.first as? UINavigationController else { return }
        let story: StoryController =  firstNavi.viewControllers.first as! StoryController
        story.reloadStories(topic: topic)
    }
}
