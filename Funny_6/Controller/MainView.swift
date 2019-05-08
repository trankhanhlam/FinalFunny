//
//  MainView.swift
//  Funny_6
//
//  Created by Trần Khánh Lâm on 5/6/19.
//  Copyright © 2019 FriendlyFriend. All rights reserved.
//

import UIKit

class MainView: UITabBarController {
    
    @IBOutlet weak var tabbar: UITabBar!
    
    var topic: Topic? {
        didSet {
            changeTopic()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbar.tintColor = .white
        setupTabbarItem()
    }
    private func setupTabbarItem() {
        
        let tabbarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        tabbarItem1.image = UIImage(named: "comedyFace")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        tabbarItem1.selectedImage = UIImage(named: "comedyFace1")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        tabbarItem1.title = "Story"
        tabbarItem1.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let tabbarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        tabbarItem2.image = UIImage(named: "0")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        tabbarItem2.selectedImage = UIImage(named: "1")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        tabbarItem2.title = "Favourite"
        tabbarItem2.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
 
    func changeTopic() {
        guard let listVC = self.viewControllers else { return }
        guard let firstNavi = listVC.first as? UINavigationController else { return }
        let story: StoryController =  firstNavi.viewControllers.first as! StoryController
        story.reloadStories(topic: topic)
    }
}
