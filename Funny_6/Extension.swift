import Foundation
import UIKit


extension UITableView {
    func removeUnusedCell () {
        self.tableFooterView = UIView(frame: CGRect.zero)
        self.tableFooterView?.isHidden = true
    }
}
