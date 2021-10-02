//
//  ReposListVC.swift
//  Kilowott Demo
//
//  Created by Clorida on 27/08/21.
//

import UIKit

class ReposListVC: UIViewController {
    let cellIdentifier = "ListCell"
    var repoList : [RepoModelElement]?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// MARK: UITableViewDataSource
extension ReposListVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ListCell
        cell?.data = repoList?[indexPath.row]
        return cell!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList!.count
    }
}
