//
//  LogDownloader.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/25/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import UIKit

class LogDownloader: NSObject {
    
    private let apiLogs = "https://dev.inspiringapps.com/Files/IAChallenge/30E02AAA-B947-4D4B-8FB6-9C57C43872A9/Apache.log"
    
    func loadData() {
        
        guard let dataUrl = URL(string: apiLogs) else { return }
        
        let session = URLSession.shared
        let urlRequest = URLRequest(url: dataUrl)
        let task = session.dataTask(with: urlRequest) {  (data, response, error) in
            guard error == nil else {
                //TODO: Error message
                return
            }
            
            guard let responseData = data else {
                //TODO: Error message
                return
            }
            
            guard let returnString = String(data: responseData, encoding: .utf8) else {
                return
            }
            let split = returnString.split(separator: "\n")
            let test = self.seperatedLogFileInMultipleLogs(logs: returnString)
            print("\(split)")
            
        }
        task.resume()
        
    }
    
    

    func seperatedLogFileInMultipleLogs(logs: String) -> [String] {
        return logs.components(separatedBy: "\n")
    }
    

    //My gut is telling me there is a better way of doing this other than brute force
    func getUserAndPage(log: String) -> (user: String, pageVisited:String) {
        let splitLog = log.components(separatedBy: " - - ")
        let user = splitLog[0]
        let pageName = getPageVisited(log: log)
        return (user, pageName)
    }
    
    private func getPageVisited(log: String) -> String {
        let splitLog = log.components(separatedBy: " - - ")
        guard splitLog.count > 1 else {
            return ""
        }
        
        let logSplit2 = splitLog[1].components(separatedBy: " \"GET ")
        guard logSplit2.count > 1 else {
            return ""
        }
        let finalSplit = logSplit2[1].components(separatedBy: " HTTP")
        return finalSplit[0]
    }

}
