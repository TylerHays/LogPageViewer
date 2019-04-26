//
//  LoadLogsViewController.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/25/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import UIKit

class LoadLogsViewController: UIViewController {

    lazy var loadLogsWorker: LogDownloader = LogDownloader()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    

    @IBAction func loadLogsPressed(_ sender: Any) {
        loadLogsWorker.loadData()
    }
}

