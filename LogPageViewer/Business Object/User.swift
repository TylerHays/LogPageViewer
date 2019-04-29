//
//  User.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/26/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import UIKit

class User: NSObject {
    let userName: String
    let pagesViews: [String]
    
    init (userName: String, pagesViews:[String]) {
        self.userName = userName
        self.pagesViews = pagesViews
    }
    
    func getPageViewSets() -> [[String]] {
        var workingPageViewSet: [String] = []
        var setsOfPageViews: [[String]] = []
        
        for pageView in self.pagesViews {
            workingPageViewSet.append(pageView)
            if workingPageViewSet.count < 3 {
                continue
            }
            
            if workingPageViewSet.count > 3 {
                workingPageViewSet.removeFirst()
            }
            
            if workingPageViewSet.count == 3 {
                setsOfPageViews.append(workingPageViewSet)
            }
        }
        return setsOfPageViews
    }
}

extension User {
    static func createUserFromLogs(user:String, userPageView: [UserPageView]) -> User {
        let filterPageViews = userPageView.filter{$0.user == user}
        let pageViews: [String] = filterPageViews.map{$0.pageView}
        
        return User(userName: user, pagesViews: pageViews)
    }
}
