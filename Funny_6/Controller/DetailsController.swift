//
//  DetailsController.swift
//  Funny_6
//
//  Created by Trần Khánh Lâm on 5/7/19.
//  Copyright © 2019 FriendlyFriend. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {

    @IBOutlet weak var lbl: UILabel!
    
    var story: Story?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStory(story: story!)
        setupBarButton()
    }
}

extension DetailsController {
    private func setupBarButton() {
        setupRighBarButton()
        setupLeftBarButton()
        setupTitleView()
    }
    private func setupTitleView() {
        self.title = story?.title
    }
    private func setupRighBarButton() {
        let favouriteButton = UIButton(type: .custom)
        if story?.favorite == 0 {
            favouriteButton.setImage(UIImage(named: "0"), for: .normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favouriteButton)

        }else{
            favouriteButton.setImage(UIImage(named: "1"), for: .normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favouriteButton)
        }
        
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
    }
    private func setupLeftBarButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    @objc func backButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func favouriteButtonTapped() {
        if story?.favorite == 0 {
            story?.favorite = 1
        }else{
            story?.favorite = 0
        }
        setupRighBarButton()
        FunnyDB.shared.updateStoryByFavorite(story: story!)
    }
    private func loadStory(story: Story) {
        let storyNotRemoveTag = (story.content)
        //convert HTML
        Helper.parseHTMLContent(storyNotRemoveTag) { (true, string) in
            DispatchQueue.main.async {
                self.lbl.text = string
            }
        }
    }
}
