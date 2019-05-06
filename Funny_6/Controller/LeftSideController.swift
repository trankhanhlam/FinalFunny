//
//  LeftSideController.swift
//  
//
//  Created by Trần Khánh Lâm on 5/6/19.
//

import UIKit

class LeftSideController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var listTopic: [Topic] = []
    var mainView: MainView!
    override func viewWillAppear(_ animated: Bool) {
        FunnyDB.shared.retrieveTopics { (topics) in
            self.listTopic = topics
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension LeftSideController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTopic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForLeftSide", for: indexPath) as! LeftSideCell
        let indexRow = indexPath.row
        let topic = listTopic[indexRow]
        cell.loadInfo(topic: topic)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainView!.topic = listTopic[indexPath.row]
        self.closeLeft()
    }
}
