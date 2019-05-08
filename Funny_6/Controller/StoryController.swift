
import UIKit

class StoryController: UIViewController {
    
    @IBOutlet weak var tableViewStory: UITableView!
    @IBOutlet weak var titleNaviStory: UINavigationItem!
    
    var listStory: [Story]?
    var firstList: [Story] = []
    var topic: Topic?
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCandies = [Story]()
    
    override func viewWillAppear(_ animated: Bool) {
        FunnyDB.shared.getStorysForFirstLaunch { (stories) in
            self.firstList = stories
        }
        self.tableViewStory.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}
extension StoryController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCandies.count
        }
        return listStory?.count ?? firstList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell", for: indexPath) as! StoryCell
        
        let story: Story
        if isFiltering() {
            story = filteredCandies[indexPath.row]
        } else {
            story = listStory?[indexPath.row] ?? firstList[indexPath.row]
        }
        if let imgStory = topic?.imgName {
            cell.imgStory.image = UIImage(named: imgStory)
        }
        
        cell.loadInfo(story: story)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = listStory?[indexPath.row] ?? firstList[indexPath.row]
        let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsController") as! DetailsController
        detailController.story = story
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


extension StoryController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCandies = listStory?.filter({( story : Story) -> Bool in
            return story.title.lowercased().contains(searchText.lowercased())
        }) ?? firstList.filter({ (story: Story) -> Bool in
            return story.title.lowercased().contains(searchText.lowercased())
        })
            self.tableViewStory.reloadData()
    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension StoryController {
    
    private func setupView() {
        self.titleNaviStory.title = "Tiếu Lâm"
        setupSearchController()
        setupLeftBarButton()
    }
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Stories"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.barTintColor = .red
    }
    func reloadStories(topic: Topic?) {
        self.topic = topic
        FunnyDB.shared.getStorys(topic: topic!) { (stories) in
            self.listStory = stories
            self.titleNaviStory.title = topic?.name
            self.tableViewStory.reloadData()
        }
    }
    private func setupLeftBarButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "list"), for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
    }
    @objc func leftBarButtonTapped() {
        slideMenuController()?.openLeft()
    }
}
