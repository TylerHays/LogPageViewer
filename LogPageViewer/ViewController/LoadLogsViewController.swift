//
//  LoadLogsViewController.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/25/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import UIKit

class LoadLogsViewController: UIViewController {
    
    let showPageSetsSegue = "ShowPageSetsSegue"
    lazy var loadLogsWorker: LogDownloader = LogDownloader(delegate: self)
    var loadedPagesets: [PageViewSet]?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showPageSetsSegue {
            guard let vc = segue.destination as? LogPagesetViewController,
            let pageSets = loadedPagesets else {
                return
            }
            vc.setupView(with: pageSets)
        }
    }
    
    func showSpinner(_ showSpinner: Bool) {
        self.spinnerView.isHidden = !showSpinner
        if (showSpinner){
            self.spinner.startAnimating()
        } else {
            self.spinner.stopAnimating()
        }
    }
    
    @IBAction func loadLogsPressed(_ sender: Any) {
        showSpinner(true)
        loadLogsWorker.loadData()
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var spinnerView: UIView!
}

extension LoadLogsViewController: LogDownloaderDelegate {
    
    func logDownloader(_ downloader: LogDownloader, logEntries: [String]) {
        let pagesets = LogProcessor.processLogEntries(logEntries)
        showSpinner(false)
        loadedPagesets = pagesets
        self.performSegue(withIdentifier: showPageSetsSegue, sender: self)
    }
    
    func logDownloaderError(_ downloader: LogDownloader) {
        showSpinner(false)
        self.showOKAlertMessage(title: "Error", message: "There was an error getting the logs. Please check your internet connection and try again")
    }
}
