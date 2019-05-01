//
//  LogDownloader.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/25/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import UIKit


protocol LogDownloaderDelegate {
    func logDownloader(_ downloader:LogDownloader, logEntries: [String])
    func logDownloaderError(_ downloader:LogDownloader)
}

class LogDownloader {
    
    var downloaderDelegate: LogDownloaderDelegate?
    
    private let apiLogs = "https://dev.inspiringapps.com/Files/IAChallenge/30E02AAA-B947-4D4B-8FB6-9C57C43872A9/Apache.log"
    
    
    init(delegate: LogDownloaderDelegate) {
        self.downloaderDelegate = delegate
    }
    
    func loadData() {
        
        guard let dataUrl = URL(string: apiLogs) else { return }
        
        let session = URLSession.shared
        let urlRequest = URLRequest(url: dataUrl)
        let task = session.dataTask(with: urlRequest) {  (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.downloaderDelegate?.logDownloaderError(self)
                }
                return
            }
            
            guard let responseData = data else {
                DispatchQueue.main.async {
                    self.downloaderDelegate?.logDownloaderError(self)
                }
                return
            }
            
            guard let returnString = String(data: responseData, encoding: .utf8) else {
                return
            }
            let logList = returnString.components(separatedBy: "\n")
            let finalList = logList.filter({!$0.isEmpty})
            DispatchQueue.main.async {
                self.downloaderDelegate?.logDownloader(self, logEntries: finalList)
            }
            
        }
        task.resume()
        
    }
}
