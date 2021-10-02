//
//  ListTableCell.swift
//  Kilowott Demo
//
//  Created by Clorida on 27/08/21.
//

import UIKit
class ListCell: UITableViewCell {
    var data:RepoModelElement? {
        didSet{
            setupData()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reposLabel: UILabel!
    @IBOutlet weak var imgView: ImageView!
    func setupData() {
        self.titleLabel?.text = data?.fullName
        self.reposLabel?.text = data?.owner.starredURL
        self.imgView?.loadImageWithUrl( URL(string: data?.owner.avatarURL ?? "")!)
        self.imgView?.maskCircle()
    }
}
