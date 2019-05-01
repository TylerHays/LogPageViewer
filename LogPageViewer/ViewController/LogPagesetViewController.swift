//
//  LogPagesetViewController.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/30/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import UIKit

class LogPagesetViewController: UIViewController {
    
    var pageViewSets: [PageViewSet]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupView(with pageViewSets: [PageViewSet]) {
        self.pageViewSets = pageViewSets 
    }
}

extension LogPagesetViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageViewSets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pageset = pageViewSets?[indexPath.row] else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PageCountTableViewCell", for: indexPath) as? PageCountTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(with: pageset)
        return cell
    }
    
    
}

extension LogPagesetViewController : UITableViewDelegate {
    
}
