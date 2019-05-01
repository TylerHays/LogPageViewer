//
//  PageCountTableViewCell.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/29/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import UIKit

class PageCountTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(with pageSet:PageViewSet) {
        page1Label.text = pageSet.page1
        page2Label.text = pageSet.page2
        page3Label.text = pageSet.page3
        pagesetCount.text  = "\(pageSet.setCount)"
    }

    @IBOutlet weak var page1Label: UILabel!
    @IBOutlet weak var page2Label: UILabel!
    @IBOutlet weak var page3Label: UILabel!
    @IBOutlet weak var pagesetCount: UILabel!
}
